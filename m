From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Mon, 22 Mar 2010 03:41:38 +0100
Message-ID: <201003220341.38918.chriscool@tuxfamily.org>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com> <f3271551003210525l761cf36eh69cdfddf4e645ef3@mail.gmail.com> <alpine.LNX.2.00.1003212011280.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 03:42:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtXaZ-0003K1-OX
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 03:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812Ab0CVCly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 22:41:54 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:37436 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753708Ab0CVClx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 22:41:53 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id CB8EA81801E;
	Mon, 22 Mar 2010 03:41:43 +0100 (CET)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B2251818036;
	Mon, 22 Mar 2010 03:41:40 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <alpine.LNX.2.00.1003212011280.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142885>

On Monday 22 March 2010 01:33:47 Daniel Barkalow wrote:
> One thing to keep in mind is that you'll get review at a slower rate than
> you'll make progress, and you'll need progress, review, and fixes to get
> integration. This means that the optimal pattern is to post incomplete
> things (marked [RFC PATCH]) when you've got enough there to show where
> you're going and you think the quality of the code you have is pretty
> good. Your patches go out, and you work on the next step while other
> people find them, read them, write comments, and you get the comments.
> Then you incorporate the changes for the comments into the next round (or
> you acknowledge the need for changes, but defer them to the third round,
> if you've got a second round ready). 

I agree but I think that it should be stressed that a GSoC project should be 
split into many milestones and that each milestone should be in itself a 
worthwhile improvement to the previous state. So that when a milestone is 
reached, the code can be sent to the list for review (marked [RFC PATCH]) and 
then improved and sent again as many times as needed (marked with v1, v2, ...) 
to get it merged.

And it is important to understand that responding to reviews and doing 
whatever is needed to get the code for the first milestones merged _is more 
important_ than developing code for the next milestones.

Because it's much better for everyone at the end of the GSoC if only half of 
the project is finished but merged, rather than if all the project is "finished" 
but nothing can be merged.

The code that can't be merged will rust very fast and will probably need quite 
some work that unfortunately few people may want or be able to do fast enough 
after the end of the GSoC. And that means that basically the work that has 
been done will be mostly lost which is very _very_ frustrating for students, 
mentors, reviewers and everyone involved...

Best regards,
Christian.
