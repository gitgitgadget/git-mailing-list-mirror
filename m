From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 13:00:45 +0200
Message-ID: <200610201300.46361.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carl Worth <cworth@cworth.org>, Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 13:00:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gas7O-0004Q9-Vy
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 13:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422748AbWJTLAq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 20 Oct 2006 07:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161126AbWJTLAq
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 07:00:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:9010 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161087AbWJTLAp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 07:00:45 -0400
Received: by ug-out-1314.google.com with SMTP id o38so713379ugd
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 04:00:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Wfe+T/72aBsM0W6uHBC1+PjqFcW6al2gpjzjWqYwmPeZzUVWAdg0ndJnQ31jzUpub0lSbuor6lvZ3QaouEcv/8ob0A9NKv8TFGvFEGf/VDsqOU5Z0xNi0TQdKehh1y6DlvFINOr9rna6BGJQKMHk6T/q6tfJYClTmuhd5n3OvZA=
Received: by 10.67.101.8 with SMTP id d8mr1665793ugm;
        Fri, 20 Oct 2006 04:00:43 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id j2sm53172ugf.2006.10.20.04.00.43;
        Fri, 20 Oct 2006 04:00:43 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <45382120.9060702@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29446>

Aaron Bentley wrote:

> Bazaar encourages you to stick lots and lots of branches in your
> repository. =A0They don't even have to be related. =A0For example, my=
 repo
> contains branches of bzr, bzrtools, Meld, and BazaarInspect.

GIT encourages you to use separate repositories for unrelated projects.
And alternates mechanism for related projects (like different Linux
kernel repositories: Linus, stable, etc.).

--=20
Jakub Narebski
Poland
