From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: [PATCH] Add git-annotate - a tool for annotating files with the revision and person that created each line in the file.
Date: Wed, 8 Feb 2006 16:09:50 +0100
Message-ID: <20060208150950.GA29346@ebar091.ebar.dtu.dk>
References: <11394103753694-git-send-email-ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 08 16:28:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6rCy-0004m7-Ct
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 16:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWBHP0J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 10:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWBHP0J
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 10:26:09 -0500
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:65244 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S1030349AbWBHP0I
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 10:26:08 -0500
Received: (qmail 29350 invoked by uid 5842); 8 Feb 2006 15:09:50 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11394103753694-git-send-email-ryan@michonline.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15737>

On Wed, Feb 08, 2006 at 09:52:55AM -0500, Ryan Anderson wrote:
> Signed-off-by: Ryan Anderson <ryan@michonline.com>
> 
> ---
> 
> I think this version is mostly ready to go.
> 
> Junio, the post you pointed me at was very helpful (once I got around to
> listening to it), but the code it links to is missing - if that's a
> better partial implementation than this, can you ressurrect it
> somewhere?  I'd be happy to reintegrate it together.

Does it depends on some ealier patch?  I get this:

git]$ git-annotate diff-delta.c
Undefined subroutine &main::all_lines_claimed called at
/home/peter/bin/git-annotate line 124.

The patch was applied to: git version 1.1.6.gd19e-dirty.

Peter
