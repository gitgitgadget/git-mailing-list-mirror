From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Thu, 23 Apr 2009 21:34:56 -0500
Message-ID: <b4087cc50904231934h17a090d4ie2a091843457eced@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org>
	 <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com>
	 <20090424022900.GB6321@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Apr 24 04:37:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxBHw-0000WK-8i
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 04:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054AbZDXCe6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 22:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754675AbZDXCe5
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 22:34:57 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:47046 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbZDXCe5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 22:34:57 -0400
Received: by qw-out-2122.google.com with SMTP id 5so743008qwd.37
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 19:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3lkgyh4fcBkb8zAZ9ko3rGTc4WRATMd/j6pIRyiPG84=;
        b=u080ASCIWA/RAFPWVGRYOxq1mAthhicyAnuMJNgVHcVI7SvfMWzlKWJp9s1Lurp7bt
         +SNUvB5h56Xso1Dlkaki4v8ys8lXDLO8DaL8BS+YaEb2tC67EZ4g1AqMTmt/js1vcemc
         Fj+NjA1wnuLhuy/E/TPyYO7iBuhvdJQ96INfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fvmzYZ5ntrY6G4Mn87fsoFSRpqM+5svWrdZfhzQ0gbJhCkE0X2hQoSkiuCU1RDskgC
         j66I4j6XlP+E0rYbgd82EEEEZ98iTigBYau9AWNJHKM7p8QwpKEQi6JvAvNnrzLw1PZQ
         J8RolAF+tyHb9qcdBZj5PEdD6wvoC7/mseUcg=
Received: by 10.224.11.136 with SMTP id t8mr2261914qat.73.1240540496253; Thu, 
	23 Apr 2009 19:34:56 -0700 (PDT)
In-Reply-To: <20090424022900.GB6321@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117403>

On Thu, Apr 23, 2009 at 21:29, J. Bruce Fields <bfields@fieldses.org> w=
rote:
> OK, but let's not over-generalize: the person that just wants to figu=
re
> out whether the driver for their network card was fixed in today's
> network devel tree shouldn't have to sit through a discussion of the
> object database. =A0And even among readers that are in it for the lon=
g
> haul, I think many people will react better to something that gives t=
hem
> at least a little concrete how-to information up front.

A quick shell synopsis is probably what you want then. Beyond that,
casual users should be ignored; quick instructions are usually
provided by each project anyway.
