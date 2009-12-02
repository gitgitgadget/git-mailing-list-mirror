From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git GUI client SmartGit released
Date: Wed, 2 Dec 2009 08:48:10 -0800
Message-ID: <20091202164810.GB31648@spearce.org>
References: <4B161B15.2020106@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 17:48:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFsNJ-00054R-9c
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 17:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976AbZLBQsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 11:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754028AbZLBQsI
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 11:48:08 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:46980 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbZLBQsH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 11:48:07 -0500
Received: by gxk26 with SMTP id 26so316226gxk.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 08:48:14 -0800 (PST)
Received: by 10.101.172.3 with SMTP id z3mr316722ano.3.1259772493058;
        Wed, 02 Dec 2009 08:48:13 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 5sm622358yxd.71.2009.12.02.08.48.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Dec 2009 08:48:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B161B15.2020106@syntevo.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134348>

Marc Strapetz <marc.strapetz@syntevo.com> wrote:
> We are proud to announce the general availability of our Git client
> SmartGit[1]:
> 
>  http://www.syntevo.com/smartgit/index.html

Congrats on your release.

I noticed you use JGit and the Trilead SSH client.

I'm curious, did you guys replace JSch because its a pile of junk?
Did you patch JGit to use Trilead SSH instead of JSch?  If so,
would you be interested in contributing that change back to JGit?
I'm rather fed up with JSch...  :-)

-- 
Shawn.
