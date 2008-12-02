From: "Joe Fiorini" <joe@faithfulgeek.org>
Subject: Re: git-svn rebase "problems"
Date: Tue, 2 Dec 2008 09:56:45 -0500
Message-ID: <73fd69b50812020656u3fd17015n267f694236982e5@mail.gmail.com>
References: <73fd69b50811301917j6535f289uf177976707914e46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 15:58:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7WhY-0006i7-7K
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 15:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbYLBO4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 09:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754471AbYLBO4r
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 09:56:47 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:60231 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407AbYLBO4q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 09:56:46 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1201181yxm.1
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 06:56:45 -0800 (PST)
Received: by 10.142.215.5 with SMTP id n5mr4935377wfg.5.1228229805258;
        Tue, 02 Dec 2008 06:56:45 -0800 (PST)
Received: by 10.143.5.14 with HTTP; Tue, 2 Dec 2008 06:56:45 -0800 (PST)
In-Reply-To: <73fd69b50811301917j6535f289uf177976707914e46@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102139>

Are there any other details I can provide to get an answer on this?

Thanks!
Joe

On Sun, Nov 30, 2008 at 10:17 PM, Joe Fiorini <joe@faithfulgeek.org> wrote:
> I'm having some problems with git svn rebase. I'm pretty sure this is
> just the way git works, not a problem per se. But it's causing trouble
> for me and my team.
> My team is currently on Subversion. I'm trying to convince some people
> that git is a good way to go.
>
> So I'm using git-svn. My team tends to commit to the svn server fairly
> often. It has happened more than once that, because git svn rebase
> applies each svn commit sequentially, some of the commits will
> conflict with each other - whether or not I have ever touched the
> file. Obviously, this is a big problem because if I've never touched
> the file, then I probably won't know exactly how to resolve the merge
> (the merge markers haven't been solely reliable).
>
> Is there anything I could do to get around this without having to
> merge code I'm unfamiliar with?
>
> Thanks all!
> Joe Fiorini
> --
> joe fiorini
> http://www.faithfulgeek.org
> // freelancing & knowledge sharing
>



-- 
joe fiorini
http://www.faithfulgeek.org
// freelancing & knowledge sharing
