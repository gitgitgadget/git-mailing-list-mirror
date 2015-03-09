From: Christian Couder <christian.couder@gmail.com>
Subject: Re: git-scm.com website
Date: Mon, 9 Mar 2015 18:12:30 +0100
Message-ID: <CAP8UFD1y86wqg5fpRn1wsMnn8JT9KXuDMgzcseH=sv8NBWO6wA@mail.gmail.com>
References: <CAJo=hJsbbfK-_qX6sg3Azk30Kz5ebLfyMbVF98VzHZe8YyaLcQ@mail.gmail.com>
	<87y4n6kvdu.fsf@fencepost.gnu.org>
	<CAJo=hJt_PHMEdpfRA0EKQyoH4XhYh89tvajewM28pgxzZ9ONMg@mail.gmail.com>
	<87twxuktzc.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 18:12:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV1EP-0000Bl-UO
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 18:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbbCIRMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 13:12:36 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:44898 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbbCIRMb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 13:12:31 -0400
Received: by igdh15 with SMTP id h15so23166501igd.3
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 10:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=crK77zxd2hm6h2Ir3hm52MdlyAa3gueGk7MouKiUXhE=;
        b=ejN+VnZ3E3dM18tSKjZpZyyA2gvPOVvFW3BLlqHWQz+5hwS54KK3Lh6loc5G/h/k0G
         lXsSA/Ch9l2Jw0YYvMItPvt3OpsdWteiCiGqLjdkno2gHLAWeCxpLeFoLLs/hbXH5Bc7
         sNYuC4HJm606qNM5A65Ol6QNvlHHC+5/N/Rou1CKmlcAiCgLiLspiA2d1v4qupy/vEEb
         jkJqVak76YXlZPjzbxI67MxeVKC7B62A2i7u4q6SmN7xKPaNhogS/sbIa0b/qjHzUbuH
         ONMLoMzJ+GwpKKc8Gymt3f2RSKQQaLOTvdQURC8jgO6W5wQtj2BottYAn1o6TqZbyZjR
         iW/A==
X-Received: by 10.50.176.196 with SMTP id ck4mr77078622igc.40.1425921150877;
 Mon, 09 Mar 2015 10:12:30 -0700 (PDT)
Received: by 10.50.245.144 with HTTP; Mon, 9 Mar 2015 10:12:30 -0700 (PDT)
In-Reply-To: <87twxuktzc.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265181>

On Mon, Mar 9, 2015 at 5:37 PM, David Kastrup <dak@gnu.org> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> On Mon, Mar 9, 2015 at 9:06 AM, David Kastrup <dak@gnu.org> wrote:
>>> Shawn Pearce <spearce@spearce.org> writes:
>>>
>>>> On Mon, Mar 9, 2015 at 6:57 AM, Michael J Gruber
>>>> <git@drmicha.warpmail.net> wrote:
>>>>>
>>>>> Since we're talking business: git-scm.com still looks a bit like a
>>>>> ProGit/Github promotion site. I don't have anything against either, and
>>>>> git-scm.com provides a lot of the information that users are looking
>>>>> for, and that are hard to find anywhere else; it's a landing page. It
>>>>> just does not look like a "project home".
>>>>
>>>> Yes, git-scm.com is a place to point people.
>>>
>>> It features "Companies & Projects Using Git" at the bottom.  Not
>>> "supporting" but "using".
>>>
>>> Linux is point 10 on that list.  The first 6 items are Google, facebook,
>>> Microsoft, Twitter, LinkedIn, and Netflix.
>>>
>>> Even for an OpenSource project that does not buy into the Free Software
>>> philosophy, that is a mostly embarrassing list of companies to advertise
>>> for.
>>>
>>> Personally, I consider the recent migration of the Emacs repository to
>>> Git a bigger endorsement but then that's me.
>>>
>>> It might make sense to reduce this list just to "Projects" since those
>>> are actually more tangible and verifiable.  Or scrap it altogether.
>>
>> At the bottom of the git-scm.com page there is this blurb:
>>
>>   This open sourced site is hosted on GitHub.
>>   Patches, suggestions and comments are welcome
>>
>> And that text contains a link to the GitHub repository[1] where anyone
>> can propose modifications to the page. Unfortunately I don't know of
>> anyone paying out contribution stipends for content changes made to
>> git-scm.com.
>
> Yeah, thanks for the cheap shot.  I already understood that category B
> is subject to contempt.  Congrats on being category A or C.
>
>> [1] https://github.com/git/git-scm.com/blob/master/README.md#contributing
>
> Turns out that "anyone" is actually "anyone accepting the conditions for
> a GitHub account":
>
>     If you wish to contribute to this website, please fork it on GitHub,
>     push your change to a named branch, then send a pull request.
>
> I've read the rather longish Terms&Conditions of GitHub and found myself
> unwilling to agree to them.  Which does not mean that changing the ways
> of contributing to the Git website to accommodate me would make any
> sense since obviously I don't have a clue what a member of the "Git
> community" should be proud of and ashamed of and thus would be unable to
> make a meaningful proposal anyway even if I were into website
> programming.

A few other points about git-scm.com:

* as Michael says it "still looks a bit like a ProGit/Github promotion site"

* some of the pull request can be rejected even if the developers want
them, like this pull request to add back a list of contributors was:

https://github.com/git/git-scm.com/pull/216

(By the way this pull request talks about bugs in
https://github.com/git/git/graphs/contributors that are still not
fixed...)

It is kind of strange to say that we should contribute to a web site
that promotes ProGit and GitHub a lot and where our contributions can
be rejected because it is not maintained by us.
