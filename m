From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git wish page
Date: Fri, 27 Apr 2007 16:26:00 +0100
Message-ID: <200704271626.07562.andyparkins@gmail.com>
References: <f36b08ee0704251505r226a8011h180ec6a8fb4ba5b7@mail.gmail.com> <200704271650.27923.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Yakov Lerner" <iler.ml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 17:26:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhSL9-000336-Ub
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 17:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755918AbXD0P0W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 11:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755951AbXD0P0W
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 11:26:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:54568 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755918AbXD0P0U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 11:26:20 -0400
Received: by ug-out-1314.google.com with SMTP id 44so838329uga
        for <git@vger.kernel.org>; Fri, 27 Apr 2007 08:26:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jM+mql2MHrllGWaDpvrU8pcY1svxKQWTKJLV21GuICvsXN3F/qhlDxWigJJ/+al5Ez3k+fFfbEJr3RyuC3wGNhm5qhTPIAAkhjMBTLnuJeSWOAln6ZTvQcp2bAfPsAQy464t5LBQLhhU92AV71x7waI1uboV9CXhlWnlrS5cIqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QEsAFYUvgww3+YCfhR8cBSS8VJos1NTAMWNV0mdowbRFJveC3Ta9zstnSgCYT+Q94TXGfH2Kt/8Ou87PjPxRKJuNFj4Hq3jxtj+4cpx25Ub1lBkXc9XJglDPb18I4cL+XCGxx1VhIPSyZVFG2Dbm7xX0707Q/HsMJy04ij8uX4U=
Received: by 10.82.152.16 with SMTP id z16mr5971705bud.1177687578930;
        Fri, 27 Apr 2007 08:26:18 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z34sm395384ikz.2007.04.27.08.26.14;
        Fri, 27 Apr 2007 08:26:17 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <200704271650.27923.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45724>

On Friday 2007 April 27, Jakub Narebski wrote:

>  Q. Can I add empty directories?
>
>  A. No, git only cares about files, or rather git tracks content and
>     empty directories have no content.

I don't object to git not tracking directories, but that's not a good 
justification for why git doesn't.  git will happily track an empty file and 
that has no content.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
