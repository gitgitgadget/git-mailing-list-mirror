From: "Matt Graham" <mdg149@gmail.com>
Subject: Re: Git Branding Overview, Re: Git.or.cz Experimental Design
Date: Sun, 20 Jul 2008 17:21:54 -0400
Message-ID: <1c5969370807201421j7fb5a93bq665b09284af0f93a@mail.gmail.com>
References: <5fb1d2400807022011w7f8d79dbk68a64dc1b8b01d98@mail.gmail.com>
	 <20080718103918.GO10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "David Baldwin" <baldwindavid@gmail.com>, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Jul 20 23:22:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKgMq-0006Ip-4v
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 23:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbYGTVV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 17:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbYGTVV4
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 17:21:56 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:17994 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbYGTVVz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 17:21:55 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1266128wfd.4
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 14:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QoWhBNe7wWayHp2Rcjk5wf0niqOMQxR4AsO0UP4VN9M=;
        b=DBaRAETA8aBpXWJ84oxQ3jjC5/SMyou4P6P1csfzVRXZ73WefqysK//0OVnHD0Pl/n
         PWadSxFO30ozST32N29Z6xejTz7U/8FBHcNNlzy0q2BePiMHgqOMbHapFsJioJBWLKJO
         s/sgNSX31x56/NpLZ3ypFKcQaUuYRqC8CbSME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=faGjxLqa59vs8Nu7CkvpbB0dT6Xehqt5GrJnf1VFZMtlXm2N31GEyTl0yZT6GpKyAn
         rjIwEkVjsyOmoPrMQ+H9GL+Z60Ack4BMXZJlkQUxjbb1L9vMUa2jSz0T5getx0kGeCSj
         bdmFO33X4ZddzXzoIluotmSCDdhqw1c3uSauU=
Received: by 10.142.116.13 with SMTP id o13mr1023526wfc.210.1216588914083;
        Sun, 20 Jul 2008 14:21:54 -0700 (PDT)
Received: by 10.142.49.13 with HTTP; Sun, 20 Jul 2008 14:21:54 -0700 (PDT)
In-Reply-To: <20080718103918.GO10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89234>

I like the existing icons with
---
+++

Please don't get rid of the minuses and pluses.


On Fri, Jul 18, 2008 at 6:39 AM, Petr Baudis <pasky@suse.cz> wrote:
>  Hi,
>
> On Wed, Jul 02, 2008 at 11:11:02PM -0400, David Baldwin wrote:
>> Hello Petr:
>> I hope you are doing well.  I was looking at the git.or.cz site tonight and
>> thought it could perhaps use a little freshening up from a design
>> standpoint.  Therefore, I messed around with the default stylesheet and the
>> home page a bit and made a logo.  You can take a look at the experimental
>> design at this address...
>> http://baldwindev.com/git.or.cz/
>>
>> It's really just a few little changes.  If you're interested in implementing
>> any of this into the current site, feel free to grab the changes from my
>> github git repository.  You can see the few text changes in the diff...
>> http://github.com/bilson/gitorcz_redesign/tree/master
>
>  I'm not sure if this is really an improvement on the current state,
> but then again, the current state pretty much matches my idea and maybe
> others will agree that your proposal is better. Thus, it's better to
> show this to the Git community at large. :-)
>
>  If you or anyone is shooting for a re-design, I would suggest to
> somehow relate to the current "Git brandings" in use:
>
>        http://git.or.cz/git-logo.png
>        http://henrik.nyh.se/uploads/git-logo.png
>
>  If you think you have a cooler logo, that's fine too, but then it's
> again better to present it explicitly, I believe. The latter is used
> especially within mSysGit, the former is used more widely - at the
> current homepage, as Gitweb logo, and in various modifications like
>
>        http://git.nyh.se/git-favicon.png
>        http://members.cox.net/junkio/git.png
>        http://unfuddle.com/images/screens/source.big.jpg
>                (top left ;)
>
> --
>                                Petr "Pasky" Baudis
> GNU, n. An animal of South Africa, which in its domesticated state
> resembles a horse, a buffalo and a stag. In its wild condition it is
> something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
