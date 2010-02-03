From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: gitk translation updates needed?
Date: Wed, 3 Feb 2010 11:13:10 +0100
Message-ID: <201002031113.11212.barra_cuda@katamail.com>
References: <20100201151647.GB8916@spearce.org> <7vy6jbunu8.fsf@alter.siamese.dyndns.org> <7vd40nundv.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 11:11:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NccCx-0001n9-Mz
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 11:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401Ab0BCKLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 05:11:34 -0500
Received: from smtp183-pc.aruba.it ([62.149.157.183]:58775 "HELO
	smtp2-pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S932276Ab0BCKLd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 05:11:33 -0500
Received: (qmail 21413 invoked by uid 89); 3 Feb 2010 10:11:17 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on smtp2-pc.ad.aruba.it
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.5
Received: from unknown (HELO darkstar.localnet) (barra?cuda@katamail.com@78.134.65.18)
  by smtp2-pc.ad.aruba.it with SMTP; 3 Feb 2010 10:11:17 -0000
User-Agent: KMail/1.11.4 (Linux/2.6.32.7-mike-1mike; KDE/4.2.4; i686; ; )
In-Reply-To: <7vd40nundv.fsf_-_@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138823>

On Wednesday 03 February 2010, Junio C Hamano wrote:
> Generating catalog po/it.msg
>  msgfmt --statistics --tcl po/it.po -l it -d po/
>  282 translated messages, 1 fuzzy translation, 6 untranslated messages.

I don't get any fuzzy translation here, but I used to, so I guess it
regards the copyright message. If that's the case, maybe msgfmt
mishandles the (C)opyright sign (or maybe gitk uses a weird encoding,
I don't know).

The untranslated messages are either abbreviations (IgnCase) or
expressions I couldn't translate effectively (Cherry-picking);
they are quite understandable anyway.
