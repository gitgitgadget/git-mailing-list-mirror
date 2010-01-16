From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Fix bad quoting in documentation
Date: Sat, 16 Jan 2010 11:20:11 +0100
Message-ID: <201001161120.14846.trast@student.ethz.ch>
References: <f3271551001160002r25cb0ac7hc96891f4af22bd03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 11:20:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW5lX-0003SL-La
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 11:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319Ab0APKUT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jan 2010 05:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231Ab0APKUS
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 05:20:18 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:50508 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921Ab0APKUR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jan 2010 05:20:17 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sat, 16 Jan
 2010 11:20:14 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sat, 16 Jan
 2010 11:20:16 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.90; x86_64; ; )
In-Reply-To: <f3271551001160002r25cb0ac7hc96891f4af22bd03@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137216>

Ramkumar Ramachandra wrote:
> Reported by Fr=E9d=E9ric Bri=E8re <fbriere@fbriere.net> through
> http://bugs.debian.org/540001

Does this fix anything except the instances already handled by 71c020c
(Disable asciidoc 8.4.1+ semantics for `{plus}` and friends,
2009-07-25)?

If so, please point them out for easier review.

If not, please tell the debian guys to set ASCIIDOC8=3DYesPlease when
building the docs.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
