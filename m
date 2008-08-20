From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [EGIT PATCH 00/31] Push GUI, GUI improvements, various jgit stuff
Date: Wed, 20 Aug 2008 04:42:42 +0200
Message-ID: <48AB84A2.7010905@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com> <20080819175931.GH20947@spearce.org> <200808192121.30372.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 04:43:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVdfx-0007A7-3z
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 04:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbYHTCmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 22:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbYHTCmv
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 22:42:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:14084 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbYHTCmu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 22:42:50 -0400
Received: by ug-out-1314.google.com with SMTP id c2so644922ugf.37
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 19:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=O8IAutrLmtmhtZiWaIN9a/MEr4deHpJrL6rw/7bo0Io=;
        b=GOb4EaRYKffssB49w/Atwqx4VZWzb25cIEsINBLtEGLNyLU4cjOvjrSi/PpKIfVgFc
         Rf3VEhq2iZ2jqThn4MXoVh30dgu5B+fkizPa2nGmJO++MwFeGxn/zkX8WrNX2z0BAkVo
         9wUjI+pz3ooNyRLDvgq/FEIjMmeD3l9/oFMtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=gsghHpRjXUDFaq754vaVIjTfZpWfsGncUv36J/ewrjbdDHso8O1smiPIafopHe2+Bw
         1NGvoxWE8X/MbGHcfci+GFB275dJkhb4sR6ocADMAyoLDLZKBpPg+Mb1d8fDlwnj/W+W
         +m6npbuPZxVCo1N1RKqRxdQ7SEbgMY892n/+c=
Received: by 10.103.203.4 with SMTP id f4mr5328822muq.8.1219200168409;
        Tue, 19 Aug 2008 19:42:48 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id e10sm1352162muf.14.2008.08.19.19.42.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 19:42:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080702 Iceape/1.1.11 (Debian-1.1.11-1)
In-Reply-To: <200808192121.30372.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92952>

Robin Rosenberg wrote:
> tisdagen den 19 augusti 2008 19.59.31 skrev Shawn O. Pearce:
>> Marek Zawirski <marek.zawirski@gmail.com> wrote:
>>> Robin, Tor, I know that you were already contributing some graphics to
>>> egit. If someone of you would like to do some icon for push/fetch with
>>> pleasure, you are welcome. Otherwise I'll have to do some crappy icon
>>> instead ;) Another matter are checkboxes screenshots. I'm not sure
>>> about legality status of including them. Any ideas if/how we co use
>>> them or some another set that we can for sure?
>> So my office-mate suggests that the output of a program (in this
>> case the checkbox icon) isn't covered by the same copyright as the
>> program that created it.  So we may be OK. 
> It's not that simple. That obviously may be the case, but I'm certain
> it does not apply to individual well defined pieces of artwork (or text for
> that matter) included in the output. 
> 
>> Or we just use some 
>> other sort of icon for the checkbox.  Maybe Tor would be able to
>> come up with something useful here?
> Most annoying is that we'd need one (four) for each LAF supported.

Well, consider that they are even more of them. GTK+ has configurable 
themes (in my case it is delegation to QT with Plastik theme, where 
screenshot was made). I don't know about other platforms, but always 
having hyper-UI Mac OS X and Windows Vista may also have some 
customization options.
No matter how icons we would prepare, always there will be somebody who 
can say that these icons are somehow inconsistent with his/her LAF.

So I think, it'd better to have this mentioned ugly code workaround just 
for Mac OS (only there flashing window is so annoying). Less people 
suffering.

Or as Shawn said, we can try to make our own funny icon for Force Update 
(red "F"-enabled and gray "F"-disabled?) that is equally (in)consistent 
for everybody.

>> Anyway, most of this series looks pretty good to me.  I found a
>> few other annoying bugs in JGit and EGit as a result of testing
>> this series, but they are unrelated to the series and have been
>> there all along.  So I may try to fix them in the coming weeks.

Nice testing then, as I have spend hours on testing UI tricks and 
haven't noticed more bugs;) Beside of some indexing problems in old API.

>>>  55 files changed, 6471 insertions(+), 981 deletions(-)
>> Heh.  Been busy, hmm?  ;-)
> 
> The weather in and around the Baltic Sea has been horrible for much
> of August so far. Maybe that helped him. :)

I swear guys, I wasn't sailing for over 1 month;)
Actually, I'm now leaving for few days, so I'm sending out just fixes 
for issues pointed out by Shawn and found by me in the mean time. I'll 
squash these patches with existing commits in push branch, as it is 
probably worth nothing to keep this in history.

Fetch UI and dynamic team menu entries for push and fetch (for 
configured remotes) are underway, I'll come back to them after coming 
back home.

BTW, as another developers are getting involved in jgit/egit coding, 
maybe we could use (update) some wiki page for marking who is working on 
some topic currently? Now it's not obvious for me, and as we're not so 
numerous it would be pity to waste our time and do some redundant stuff 
one day.

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
