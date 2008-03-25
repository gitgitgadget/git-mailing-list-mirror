From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] gitk: Spanish translation of gitk
Date: Tue, 25 Mar 2008 16:37:58 +0100
Message-ID: <1b46aba20803250837x527caf4dlbb8c71d3d2719126@mail.gmail.com>
References: <1206316703-15481-1-git-send-email-sgala@apache.org>
	 <1206442102-21804-1-git-send-email-sgala@apache.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Paul Mackerras" <paulus@samba.org>
To: "Santiago Gala" <sgala@apache.org>
X-From: git-owner@vger.kernel.org Tue Mar 25 16:38:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeBEd-0006rz-Cu
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 16:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938AbYCYPiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 11:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754751AbYCYPiE
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 11:38:04 -0400
Received: from rn-out-0910.google.com ([64.233.170.190]:62456 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbYCYPiD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 11:38:03 -0400
Received: by rn-out-0910.google.com with SMTP id v46so1882163rnb.15
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 08:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=dNha21JdoxNOo6g6Ffxv6mI7sqbz8HgC7cMVQcGPYZw=;
        b=K7s5+IsdYxvie+CM3RsLiU5ZwvCSBcXf25VWPuTVGio74hPPfmLW0XcdRqZ/M7uzSZqC7CrfaPNSGmJEvclHXXqdcU5SSTr9r4MJpheytXxuT1TWHLrD3AIG+tqvfzv1f1Xp0HvrYLhLsGiPl+qwOdxR2O0h5PedADy94GTMfoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LxzaR6h3J99uCKDj2WP7oYJJvAGzfyuEZdMDloogTOJpj9NO0AjBqiPtn/HiSSrfFjea2sPzwAjb/1Rb4hRWCgZ7wsiJs9j/e6klHnXo7G7QvYQgkZz3THgT+tcPLuvOuCCyJ1f0JxoOnaUG8DOA209n0nKyGL/f/uQwubtzSUE=
Received: by 10.141.18.14 with SMTP id v14mr3414183rvi.125.1206459478226;
        Tue, 25 Mar 2008 08:37:58 -0700 (PDT)
Received: by 10.141.115.5 with HTTP; Tue, 25 Mar 2008 08:37:58 -0700 (PDT)
In-Reply-To: <1206442102-21804-1-git-send-email-sgala@apache.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78192>

2008/3/25  <sgala@hisitech.com>:
> I copied the italian translation and translated the strings
>  to Spanish starting from there.
>  The translation has been revised by Wincent Colaiuta and Carlos Rica,
>  which led to four different patches posted, including this one.
>  Amended into one single patch for inclusion.
>  See thread http://thread.gmane.org/gmane.comp.version-control.git/77983
>
>  Signed-off-by: Santiago Gala <sgala@apache.org>
>  ---
>   gitk-git/po/es.po |  890 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 files changed, 890 insertions(+), 0 deletions(-)
>   create mode 100644 gitk-git/po/es.po

First of all: Great work! It was a big effort, thanks!

Please, note that the message attached to the
commit will be stored for the future. Specific details
not related to explain the patch purpose (temporary URLs)
are usually better placed after the --- and before stats
in the mail, to make them not to appear while running
git-am, this without touching the message.

--
Carlos
