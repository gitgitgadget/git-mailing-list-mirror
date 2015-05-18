From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/14] Make git-pull a builtin
Date: Mon, 18 May 2015 21:41:12 +0200
Organization: gmx
Message-ID: <33b02d3c1d68d61c9d81eabfbaf6be48@www.dscho.org>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 21:41:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuQuf-0002d7-Bb
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 21:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbbERTlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 15:41:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:60241 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932386AbbERTlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 15:41:16 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MI5Ve-1YsnY71ZR0-003ycl; Mon, 18 May 2015 21:41:13
 +0200
In-Reply-To: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:77SwPssyN4UxkEK3NDYf4XlgW9Pi0tLA4weBMBB1U9qCImRmqBQ
 jDAy/jc+sQuwnBLNE5ibGcSLXuMq2+oEf7GwOmTT7/m74gR6vEPBBVzNUldABFxr6l7FQAV
 Ef/AlLtQKbqUYkSgCaZaSvPfBshGCTf4wjXd2juNrygqoT08BxZ/l4KUboQvf42tqyh2GBJ
 MIya8kaxwfUTlmrP3/LfQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269314>

Hi Paul,

I already commented on patches 1-10, and I will look in depth at 11-14 tomorrow.

It is a very pleasant read so far. Thank you.

Ciao,
Dscho

P.S.: I have the feeling about patch 12 that reading `opt_rebase` from the config could be delayed until after we know that the user did not specify `--rebase`, but I'll have to think about that more deeply.
