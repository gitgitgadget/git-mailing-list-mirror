From: "Matt Graham" <mdg149@gmail.com>
Subject: Re: Git Branding Overview, Re: Git.or.cz Experimental Design
Date: Mon, 21 Jul 2008 16:03:40 -0400
Message-ID: <1c5969370807211303t538d066axb8ec2f7e3d7e853e@mail.gmail.com>
References: <5fb1d2400807022011w7f8d79dbk68a64dc1b8b01d98@mail.gmail.com>
	 <20080718103918.GO10151@machine.or.cz>
	 <46a038f90807201450w57fdb523m42bc628f2dce7f87@mail.gmail.com>
	 <g61q6n$645$1@ger.gmane.org>
	 <alpine.DEB.1.00.0807211218470.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 21 22:04:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL1cg-00007u-7W
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 22:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbYGUUDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 16:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753446AbYGUUDm
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 16:03:42 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:38575 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbYGUUDl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 16:03:41 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1770012wfd.4
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 13:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=E5YCL3JxCp6yQ5lGTkippwAW0xNhdNpBoEahvQ6YSNg=;
        b=IPy9ngR4dZm9zketza85lqIg1yqh9XLKM0iYeqOcBEzC523fpGy8gHljvhhQ7vsjVz
         OK1y+G7bLnnFq4Ilp+tgtN6dPi3Wq2zOusBsLNGd3YqFzKgS9nFlLV8lCDAH7+RsVhRs
         cFczG1FdSPBx50ygFI1qkpgHLqClzKe/hz7tA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=g25m+Is6pyEHCEnwIMhcGYdHuyJDHP3W7Vq87byVxNQkj3beCO+zH72dMTMzOurTGG
         tSM7WYHwkFGUh9WIg72K3Ad93bdRvxX7g7jLu7MWn4BE3qDToDLmJivMsvZGF7lqotxd
         VQGKAL9cowPynlnCZwxVfhT7cbDNUulCpLjaA=
Received: by 10.142.154.20 with SMTP id b20mr1497170wfe.222.1216670620191;
        Mon, 21 Jul 2008 13:03:40 -0700 (PDT)
Received: by 10.142.49.13 with HTTP; Mon, 21 Jul 2008 13:03:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807211218470.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89397>

On Mon, Jul 21, 2008 at 7:20 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 21 Jul 2008, Michael J Gruber wrote:
>
>> Martin Langhoff venit, vidit, dixit 20.07.2008 23:50:
>> > On Fri, Jul 18, 2008 at 10:39 PM, Petr Baudis <pasky@suse.cz> wrote:
>> > > On Wed, Jul 02, 2008 at 11:11:02PM -0400, David Baldwin wrote:
>> > > > http://baldwindev.com/git.or.cz/
>> > > I'm not sure if this is really an improvement on the current state,
>> > > but then again, the current state pretty much matches my idea and maybe
>> > > others will agree that your proposal is better. Thus, it's better to
>> > > show this to the Git community at large. :-)
>> >
>> > FWIW, I like it. I like both the better font and whitespace layout and
>> > the 3-color-spot-merge-to-white. As Petr says, we have had the
>> > (apologies, but to me) ugly logo for a while, so it is widely used,
>> > and perhaps it has even grown on people.
>> >
>> > BazaarNG managed to grab the best concept logo of the lot, IMHO, with
>> > the 'merge' roadsign.
>> >
>> > > If you think you have a cooler logo, that's fine too, but then it's
>> > > again better to present it explicitly, I believe.
>> >
>> > Can we separate the 2 things? The better fonts and layout look like a win to
>> > me.
>> >
>> > WRT the logo, the current one is not a particularly strong image, and
>> > we haven't spent millions in plastering it over magazines or anything.
>> > So a good new logo would be something to take on.
>>
>> I like that new logo (plusminus G), too, it's very descriptive. I just want to
>> raise one question which I can't answer myself:
>>
>> Are there any potential issues with the Helvetica license?
>>
>> In any case it may be safer do redo it with a GPL sans serif font. If one
>> wants to keep the association of the shape of "G" with a circular arrow then
>> FreeSans and Nimbus Sans L seem to be the only options.
>>
>> Alternatively, it may be easier to redo it in plain PS. I'll attach 2 KISS
>> variants. 1.5k for the eps, 3 colors only.
>
> You could have spared yourself the trouble:
>
> http://repo.or.cz/w/msysgit.git?a=blob_plain;f=share/resources/gitlogo.svg;h=c0d67e70ab31394f0635c141998e512437a138b4;hb=HEAD

The sideways Git is sweet, but as a favicon, it's awfully small.  I
think it would be easier to see with just the sideways G or just the
+- as a favicon and the whole thing for larger images.
