From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: GSoC 2008 - Mentors Wanted!
Date: Wed, 5 Mar 2008 13:58:15 +0600
Message-ID: <7bfdc29a0803042358n6126286dr7a17f3b4dadbabe5@mail.gmail.com>
References: <20080304051149.GS8410@spearce.org>
	 <1b46aba20803041247h5cc64186q2abf7973372fd3ef@mail.gmail.com>
	 <20080305053612.GA8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Carlos Rica" <jasampler@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 08:59:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWoWo-0007MR-Hs
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 08:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762621AbYCEH6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 02:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756192AbYCEH6T
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 02:58:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:34486 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760770AbYCEH6R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 02:58:17 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3140368ugc.16
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 23:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=P7Jidv4rgFNm/gppu/5lf0D0pl1WYobq4QD8MypHyeA=;
        b=ujXPche4Wj4epokrQN5EHV2EdMideSXOUzDxxHnvvlqkuvxzT/KOWNHuAgQm1VEFj+owviENU/eosFX85C+jiIPozuLw5ynJKJ7Uej53fV/YsjFdt+D39UgpJwZJnXmIrc9bz7iN5D1LgjH3tB8F3ho6yB51gO/o5ftksS0qV4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UVj7D1Ep9v2CwnfW1Oa5nXwuGxZ0Vt5xd4vDwjc0lGldQJ4DJf78wdv/WBwrI1Yc/8r8CFxnX03FuXcnhrCOTFMYGsWQIgaMqp4TYWin8Illnx1KJdMPxU8vSZ86zGPY2Tm+FJYg3bg5QpKdeJ1jy+TM89fS8BGLlb/7Bo7g77g=
Received: by 10.78.192.20 with SMTP id p20mr5567047huf.5.1204703895437;
        Tue, 04 Mar 2008 23:58:15 -0800 (PST)
Received: by 10.78.75.8 with HTTP; Tue, 4 Mar 2008 23:58:15 -0800 (PST)
In-Reply-To: <20080305053612.GA8410@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76187>

I would like to suggest 2 projects that I want to work as a developer
(and/or mentor):

1. GIT SCM Plugin for NetBeans (GPLv2 with CPE, same as NetBeans)
The aim of the plugin is to integrate GIT with NetBeans using JNI so
that any change in the implementation of GIT does not effect the SCM
plugins way of work.
Language: Java
Goal: Make GIT available from IDE for NetBeans users and use GIT using
Java Native Interfaces

2. distributed versioned web system backup and restoration framework
(GPLv2 with CPE, same as NetBeans)
[I am not sure whether this one is even qualifies or not as a GIT
Community Project]
Language: Java, NetBeans RCP
Goal: Develop a framework which can backup and restore data from
different components of web application. For example, database, ldap,
log, images, files (PHP, JSP, PY, HTML, JS, CSS etc.). Additionally
allow edit and propagation of configuration in distributed nature,
system restart, data restore. Also integrate backup and repo maintain
to Amazon S3.

I would be grateful if others would express their opinion about them.

Thank you and best regards,

Imran

On Wed, Mar 5, 2008 at 11:36 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Carlos Rica <jasampler@gmail.com> wrote:
>
> > On Tue, Mar 4, 2008 at 6:11 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
>  > >  OK, enough, onto the project list!
>  > >
>  > >   http://git.or.cz/gitwiki/SoC2008Ideas
>  >
>  > Gitster talked today about libification as a project for the GSoC
>  > (I mangled some comments, I accept complaints):
>
>  Thanks for pasting this chunk of the log Carlos.  I otherwise would
>  have certainly missed it.  Much appreciated.
>
>
>  > gitster> For the record, i've never said I am not interested in libification.
>  >
>  > gitster> However.
>
>  [... lots of good gitster remarks removed for space ...]
>
>  After some reflection I agree with Junio.  As such I have moved the
>  libification project down the page to a new category, "Projects So
>  Large Your Head Will Spin".
>
>
>  > gitster> "rewrite git-submodule, put the repository for submodules in
>  > the superproject $GIT_DIR/modules, and use .git-file (currently in
>  > 'pu') to point at it", would be a good sized one.
>  ...
>
> > gitster> "teach 3-way fallback logic git-am has to git-apply".
>
>  These have gone onto the list as smaller, more average sized
>  projects.  Both are interesting and useful.  Thanks Junio.
>
>  --
>  Shawn.
>
>
> --
>  To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
