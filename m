From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Google Summer of Code 2008
Date: Sun, 2 Mar 2008 17:46:04 +0100
Message-ID: <200803021746.05629.jnareb@gmail.com>
References: <200802262356.28971.jnareb@gmail.com> <200803020053.09815.jnareb@gmail.com> <vpqlk516rh6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Mar 02 17:47:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVrLA-00072R-KB
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 17:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbYCBQqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 11:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753803AbYCBQqG
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 11:46:06 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:39613 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648AbYCBQqF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 11:46:05 -0500
Received: by nf-out-0910.google.com with SMTP id g13so3061290nfb.21
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 08:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=OPxnvC+z7RXMgxgZyxQk36QJzlf2qfOZ/qqjN+0k4jw=;
        b=miRuywETyte60qRmNxHLzhOOTjAQz2oG0Cy7eE0fIkGF9IxVXIYc8cJY6DOKLtbtgpA4v7mMCAHHed/WFnkJNSJOlM11Xnn15XMFTM1wMZBdNQZnHkgmgM7DMhSIP5QrOXZ8J2t7YMMc5WvyWj/6t6DDNavywrPw6tlODVZ4nNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UDClRA3BxjAk65yvAFxizmcpt7UJAIzpG/EnGH+MYGkmD87wf7W+bpLcptMHDSxqyLEspcgq+snEdHUcj8p+JO0makvETzSJT0YvphlpNGcW5XQJdQQXH9ZitdJwXZem0ds0cx7npsmRZL8u0pMrKt9g8MLVCVZ/S9PPDs9pHRg=
Received: by 10.82.121.15 with SMTP id t15mr18236264buc.31.1204476363385;
        Sun, 02 Mar 2008 08:46:03 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.212.124])
        by mx.google.com with ESMTPS id z33sm20899181ikz.0.2008.03.02.08.46.00
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 08:46:02 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <vpqlk516rh6.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75804>

[Cc list culled]

On Sun, 2 Mar 2008, Matthieu Moy wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>>
>> * GNU Emacs git GUI
>>
>>   Make git mode for Emacs full featured git GUI, and not only commit
>>   tool, following ideas of PCL-CVS... and its limitation. I guess that
>>   DVC (http://download.gna.org/dvc) git mode is one thing to examine
>>   searching for features to implement, but from what I have read in
>>   documentation it is quite a but GNU Arch centric.
> 
> The documentation is, but the tool isn't. Actually, DVC started as
> "Xtla", which was _only_ a GNU Arch interface. The tool evolved a lot
> since then, but the documentation is totally outdated :-(.

I wanted then tro try DVC out, but when comiling it I get the
following error message:

  Cannot open load file: dvc-site
  make[1]: *** [clean-some] Error 255
  make[1]: Leaving directory `/tmp/dvc-snapshot/++build/lisp'
  make: *** [dvc] Error 2

GNU Emacs 21.4.1, after running autoconf and ./configure.
Today's snapshot.
-- 
Jakub Narebski
Poland
