From: Joachim Schmitz <jojo@schmitz-digital.de>
Subject: Re: read() MAX_IO_SIZE bytes, more than SSIZE_MAX?
Date: Thu, 12 Feb 2015 08:46:03 +0100
Message-ID: <5mk9xxhpoob8bt90hfd3a6bl.1423727010868@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 08:46:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLoTl-0001z2-3m
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 08:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276AbbBLHqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 02:46:25 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:62185 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbbBLHqY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 02:46:24 -0500
Received: from [192.168.178.46] ([94.221.139.52]) by mrelayeu.kundenserver.de
 (mreue102) with ESMTPSA (Nemesis) id 0LfAa0-1XoxgB2YTw-00oneS; Thu, 12 Feb
 2015 08:46:03 +0100
X-Provags-ID: V03:K0:TrfuLWB8IUJo7mGUQjk/Q7twwVcRvClBAKa/bDn9gHDMjkTLrRs
 9RRnGdGlYnA67tyzvCX3VWrV+FYV3oQb0UbmXv2BvWAyFYwh7nt95HGEFMTm/EjUsRPd8fB
 RAwFtb6i2w5On9ghafsWjt+Jqa6LLORKiaBq1wiRIp7kNAo7yb/duA6UA6zjdykAqZmU2P2
 IZjsgp8MfC1uQYAbOo41w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263707>

ClNvcnJ5IHRvIGJlIGEgcGFpbiwgYnV0IGkgdGhpbmsgdGhpcyBzZW50ZW50ZW5jZSBuZWVkZSBt
ZW5kaW5nCgorICogdG8gb3ZlcnJpZGUgdGhpcywgaWYgdGhlIGRlZmluaXRpb24gb2YgU1NJWkVf
TUFYIHBsYXRmb3JtIGlzIGJyb2tlbi4KCkJ5ZSwgSm9qbw==
