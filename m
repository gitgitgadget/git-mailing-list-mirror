From: "Imran M Yousuf" <imran@smartitengineering.com>
Subject: Re: [JGIT PATCH 2/2] Move pathOf to RepositoryTestCase and use it for locating test files
Date: Thu, 4 Sep 2008 07:47:21 +0600
Message-ID: <9e85b2570809031847r34a760ecwea365930327eb205@mail.gmail.com>
References: <20080903091022.GC23406@diku.dk>
	 <20080903170904.GB28315@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jonas Fonseca" <fonseca@diku.dk>,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 03:48:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb3xV-0007IO-NR
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 03:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbYIDBrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 21:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbYIDBrY
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 21:47:24 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:3386 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbYIDBrX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 21:47:23 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1513575eyi.37
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 18:47:21 -0700 (PDT)
Received: by 10.210.79.9 with SMTP id c9mr1597845ebb.170.1220492841241;
        Wed, 03 Sep 2008 18:47:21 -0700 (PDT)
Received: by 10.210.86.13 with HTTP; Wed, 3 Sep 2008 18:47:21 -0700 (PDT)
In-Reply-To: <20080903170904.GB28315@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94877>

On Wed, Sep 3, 2008 at 11:09 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Jonas Fonseca <fonseca@diku.dk> wrote:
>>  This is a workaround patch disguised as a cleanup patch. For NetBeans I
>>  am not yet sure how to setup JGit as a project where everythng works.
>>  For now I need to be able to override the path to files used by the
>>  tests and this patch reduces that change to one single place.
>
> I wonder if we shouldn't just prod Imran to finish the Maven stuff.
> He has some patches in there that are specifically for this same
> issue under Maven.
>

Almighty willing, I will submit my patches this weekend (on Saturday).
I develop in NetBeans so that would make it easier for sure.

Cheers,

Imran

>  http://repo.or.cz/w/egit/imyousuf.git?a=shortlog;h=refs/heads/mavenize-jgit
>
> --
> Shawn.
>



-- 
Imran M Yousuf
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
