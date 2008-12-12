From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Fri, 12 Dec 2008 15:07:38 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812121459400.30035@xanadu.home>
References: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: David Howells <dhowells@redhat.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 21:09:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBEKD-0002GU-3O
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 21:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbYLLUIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 15:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbYLLUIF
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 15:08:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:47757 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbYLLUID (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 15:08:03 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KBS0071P57H8OH0@VL-MO-MR005.ip.videotron.ca>; Fri,
 12 Dec 2008 15:06:53 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102938>


Another obvious correction...

On Fri, 12 Dec 2008, David Howells wrote:

> +     A commit object will typically refer to one base commit when someone has
> +     merely committed some changes on top of the current state, and two base
> +     commits when a couple of trees have been merged.

If you have two bases, then only two trees were merged together.  If you 
merged a "couple" of trees, then a "couple" of bases are registered.


Nicolas
