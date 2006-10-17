From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 01:39:41 +0200
Message-ID: <200610180139.41647.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <4534F133.1090003@op5.se> <453532A5.6060701@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 02:14:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZz4b-00033K-Gx
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWJQXjM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Oct 2006 19:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWJQXjM
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 19:39:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:16822 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751160AbWJQXjL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 19:39:11 -0400
Received: by ug-out-1314.google.com with SMTP id o38so70725ugd
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 16:39:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KWNtpZbUZgtxZHMhgwGVtrmpvNtWIpvv/hmHgZ2HkODZpP7hS0SAa/AkNEVuGwDKa4+t21buAmfmWc82bCcAaOT91K/cjfy90lppGtifiMcwv54yZlsX0wq4ctDgTG9/29OV52Uc4UqqYd8JsI0oj8eVcLcCZKTMEmWsd/9SiI4=
Received: by 10.66.224.19 with SMTP id w19mr10748555ugg;
        Tue, 17 Oct 2006 16:39:10 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id u1sm285263uge.2006.10.17.16.39.09;
        Tue, 17 Oct 2006 16:39:09 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <453532A5.6060701@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29144>

Aaron Bentley wrote:
>> This clears things up immensely. bazaar checkout !=3D git checkout.
>> I still fail to see how a local copy you can't commit to is useful
>=20
> My bzr is run from a local copy I can't commit to. =A0To get the late=
st
> changes from http://bazaar-vcs.org, I can run "bzr update ~/bzr/dev".
> To merge the latest changes into my branch, I can run
> "bzr merge ~/bzr/dev". =A0It's also convenient for applying other peo=
ples'
> patches to.

Can you do "bzr log" in 'checkout', without need to specify "~/bzr/dev"=
?
If not, how this differs from checking out (in git terminology) outside=
=20
default working area, and requiring providing GIT_DIR or --git-dir for
stuff?
--=20
Jakub Narebski
Poland
