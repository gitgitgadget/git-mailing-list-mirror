From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 1/3] Add "vcs" config option in remotes
Date: Sun, 11 Jan 2009 20:32:36 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901112032100.19665@iabervon.org>
References: <alpine.LNX.1.00.0901110332580.19665@iabervon.org> <46dff0320901111729y3869db2bxcc2b66a7be247d0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 02:34:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMBgn-00078P-Tt
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 02:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbZALBci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 20:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbZALBci
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 20:32:38 -0500
Received: from iabervon.org ([66.92.72.58]:49236 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbZALBch (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 20:32:37 -0500
Received: (qmail 11930 invoked by uid 1000); 12 Jan 2009 01:32:36 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jan 2009 01:32:36 -0000
In-Reply-To: <46dff0320901111729y3869db2bxcc2b66a7be247d0b@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105270>

On Mon, 12 Jan 2009, Ping Yin wrote:

> On Mon, Jan 12, 2009 at 4:12 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > This will indicate to programs using the remote that it should be
> > accessed through a VCS helper. Until programs support it, have them
> > fail it the option is set.
> 
> s/it/if/ ?

Yes. It was pretty late last night when I wrote the commit messages.

	-Daniel
