From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [RFC/PATCH] Git doc: GPL2 does not apply to repo data
Date: Mon, 1 Feb 2016 08:35:22 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602010827430.2964@virtualbox>
References: <alpine.DEB.2.20.1601280913450.2964@virtualbox> <1454274011-4880-1-git-send-email-philipoakley@iee.org> <xmqq8u35xv00.fsf@gitster.mtv.corp.google.com> <6D15DFBB73355B4E9EFB1AD5EF9FCA31842442AA@NZ-EXCHANGE1.fphcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	GitList <git@vger.kernel.org>
To: Jonathan Smith <Jonathan.Smith@fphcare.co.nz>
X-From: git-owner@vger.kernel.org Mon Feb 01 08:35:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ91U-00009f-7s
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 08:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbcBAHfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 02:35:40 -0500
Received: from mout.gmx.net ([212.227.17.20]:63067 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbcBAHfj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 02:35:39 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lmwpk-1ZsCEi1f48-00h3Pn; Mon, 01 Feb 2016 08:35:24
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <6D15DFBB73355B4E9EFB1AD5EF9FCA31842442AA@NZ-EXCHANGE1.fphcare.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:XFnvnZ7E7HLd5l6HUkOebu9uutakCAvNdJVl5dVRFW4Nssvepey
 d1JIRjh6zQfkGMNldjcdAqRyScw9aR96Pkj+CjgaKBrvxOp46TNv+n35DRw9Tp8hVD7p2BL
 CZAzmVgCq+H/4rkkdFEfuFmoR/jObqee/sIyJxMI0iBLld89vcPCUK0oupbf7NfGCm/jufz
 gpD8ktY0NQ+XV7WnDdXzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Lh5RBFhUICk=:gJsXDLYwk19gNIBxc3gGP1
 Cl6FEgkoyAYHableDiA+ZkyysNuXLeLtRUJ46ArUHjykuREurcwd4GY7VR/8eEWmT6EfLaomn
 fMI1W8H+qrtqDFmAdtvJ9vgO0KfrtG4Ljj+wRb7jxGcphJ7w0ZiqCmL03TfB+n4oZeG1XLgsK
 nLOw4HFmhgZaIGPlvvh44bNDCVHxEnehTjix+UdXuYY4a0CzySINr9bTEpNoezP4a65ALXGWs
 kwJBUE0ATXqyUVntHTm9eK/mGLm2Wr1ULv4AfM9tGRsJIvEYWBYFoil5idZvHE9w8xMHmX/2j
 cqRGY9XiHm7D6V26zg2/qsX/sSbopJMpQxD4XsqJiejfRcTvlyUsijh5ePJesmeD9GQCVTrCo
 hui12V+ds8p2aS952/593niBWP1F0EfDjiRCB1u6DMG2OM7C5WiJGnnO41NJOlYaow3arTg46
 LC4bRBKApnPqqbSANXTqgDaQ0ZCo/05CIVQtL0NPfmDifZYmsQJnXkz3xd90BR99zRykEAlGh
 FSpWZcvT94m4KUFWULlnXm2KWHa36YhN/ZnHzLJvxAcHzI1jeiEmwr1wNHQC+2iWKagCXq9je
 BkP5XPiTHHDa7ENojm8K0wfP1XIQt/5rpA5ymgd9oOZyMWywZSrbTBOAiuLXfWgOxUzx6sIr4
 3IV05Ovu2LTtlAKdZbsuQd/4xgGxaCheYYciFkqNkBgY/m0L3IGbHo8TVekAb6ZiMXi/j56bB
 4X2dTB6a56okYvrIp6Nty6BDD+L221zEWZWojDC5E6WhHup75Z1hoVxvDdzqi5DI7H3G0KbJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285191>

Hi Jonathan,

On Sun, 31 Jan 2016, Jonathan Smith wrote:

> I'll be taking all of your contributions as ammo as I continue to fight
> for Git here.

I would hope that it is unnecessary to point weapons at managers to
"convince" them to use Git.

In the meantime, I think we have accumulated a lot of arguments in favor
of using Git to manage source code.

For less tech-savvy managers, I found that name dropping works quite well
(read: naming a couple of well-known companies/products that switched to
Git).

Ciao,
Johannes
