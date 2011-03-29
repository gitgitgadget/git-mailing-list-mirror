From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] git-notes.txt: clarify -C vs. copy and -F
Date: Tue, 29 Mar 2011 11:36:42 +0200
Message-ID: <201103291136.42830.johan@herland.net>
References: <09668994f10284cfa5243789a627dce8c2325bc6.1301388217.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 11:36:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4VM7-0000oq-Ks
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 11:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab1C2Jgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 05:36:51 -0400
Received: from smtp.opera.com ([213.236.208.81]:46538 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab1C2Jgu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 05:36:50 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p2T9ahd0017094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 29 Mar 2011 09:36:43 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <09668994f10284cfa5243789a627dce8c2325bc6.1301388217.git.git@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170249>

On Tuesday 29 March 2011, Michael J Gruber wrote:
> The current description of '-C' together with the analogy to 'git
> commit -C' can lead to the wrong conclusion that '-C' copies notes
> between objects. Make this clearer by rewording and pointing to
> 'copy'.
>
> The example for attaching binary notes with 'git hash-object'
> followed by 'git notes add -C' immediately raises the question: "Why
> not use 'git notes add -F'?". Answer it (the latter is not
> binary-safe).
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

Acked-by: Johan Herland <johan@herland.net>


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
