# -*- coding: utf-8 -*-

import unittest

from arch.zx48k.optimizer import cpustate


class TestCPUState(unittest.TestCase):
    def setUp(self):
        self.cpu_state = cpustate.CPUState()

    def _eval(self, code):
        lines = [x.strip() for x in code.split('\n') if x.strip()]
        for line in lines:
            self.cpu_state.execute(line)

    @property
    def regs(self):
        return self.cpu_state.regs

    def test_cpu_state_push_pop(self):
        code = """
        ld hl, 256
        push hl
        pop bc
        """
        self._eval(code)
        self.assertListEqual(self.cpu_state.stack, [])
        self.assertEqual(self.regs['hl'], self.regs['bc'])
        self.assertEqual(self.regs['h'], self.regs['b'])
        self.assertEqual(self.regs['l'], self.regs['c'])
        self.assertEqual(self.regs['h'], '1')
        self.assertEqual(self.regs['l'], '0')