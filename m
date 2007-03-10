From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Google Summer of Code '07 application
Date: Sat, 10 Mar 2007 07:06:25 +0000
Message-ID: <200703100706.28375.andyparkins@gmail.com>
References: <20070308050746.GA29778@spearce.org> <20070309153934.GA1131@spearce.org> <7vk5xq5atd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 08:09:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPvhk-0000jP-Ma
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 08:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933496AbXCJHJS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 02:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933463AbXCJHJS
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 02:09:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:54149 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933496AbXCJHJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 02:09:16 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1594982uga
        for <git@vger.kernel.org>; Fri, 09 Mar 2007 23:09:15 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ol640jdbw8QBTGMVBO5s3wZa21uZs6zphWVh1GNQX3Y8RoZrBU7XySZJpdGtbNCE6ClbVnjiCgtX6gjzbZqpitDLIBEx1+n5vdxCHe/P0ItirFodWee+z1ZmNlhBW8Ug/plB37OeSD63kuz3WqDK0haAbrj27ontV3VL2+8Wp/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mdX9Dc5IA8UflnERg4thusfHbL0nXNrhW/cRUJkfSi2+i/t6ej0g+Wxb1bsUOog+L8hiZnjbskYFjTHQF0LQ0zPlSr98TpUao6zedvxB6Ki33LQWYXyysif48Z9abvJbvm+A2TCzavbdlKF/qlmbmd0URrdDoE0JBawLQozC+Zw=
Received: by 10.67.19.13 with SMTP id w13mr11568616ugi.1173510555505;
        Fri, 09 Mar 2007 23:09:15 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 24sm5403958ugf.2007.03.09.23.09.14;
        Fri, 09 Mar 2007 23:09:14 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <7vk5xq5atd.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41853>

On Friday 2007, March 09, Junio C Hamano wrote:

> But one thing I think everybody can be proud of about this
> community is that we haven't had any meaningless flamewar at
> all.  Even the discussions on the hotter side in the past,
> perhaps primarily coming from crashing cultures, tended to
> produce useful improvements.

I have to agree.  As a relative newbie, and all-round submitter of 
opinions but not code, I have to say that the thing that keeps me 
attached to the git project where I have never become involved with 
other projects is that even when you are getting blasted and argued 
with and told you are wrong, everyone uses logical arguments; points 
are taken seriously and addressed under the assumption that the 
questioner is not an idiot.  This is different to the usual "that's 
just how it is, if you don't like it why don't you fork the project".

> One example that comes to my mind is the UI change in 1.5.0.  It
> started when Carl Worth was sufficiently irritated by how
> different and inapproachable git was to new people, and at some
> point the discussion almost went near "well, distributed is
> different from CVS, so shut up and come back later when your CVS
> braindamange is healed", but we quite didn't go that way.
> Instead, the discussion resulted in the "usability and
> teachability" theme.

It's this attitude that encouraged me to write and post my git-niggles 
list.  It was a pleasure to see positive responses, and then see Shawn 
posting patches that addressed some of them.  I would never have dared 
post something so potentially-controversial if I hadn't seen that 
people rarely get shouted down on the list.

I'd like to reiterate though - I don't think that it is the /acceptance/ 
of ideas that makes the git community strong - it is that ideas are 
taken seriously.  For me, I don't mind if something I suggest is 
ignored, never implemented or disagreed with; all I am actually after 
is the feeling that someone listened to me and understood what I was 
asking for.  "I like it but I'm not going to implement it", "here's 
where you would go if you wanted to implement that", "I see what you're 
asking for but I think that it's better to do it like this" are all 
highly acceptable responses.   Surprisingly, responses like this are 
not the norm in many projects.  Equivalents of "Get the hell off our 
mailing list" /are/ common.

In short - the thing that makes the git community great, is not their 
friendliness or their willingness to implement every request that comes 
along, it is the attitude that most people are not idiots and that 
every idea merits listening to.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
