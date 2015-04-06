From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [ANNOUNCE] Git Merge Contributors Summit, April 8th, Paris
Date: Mon, 6 Apr 2015 21:08:54 +0200
Message-ID: <CAP8UFD2rtxL29TqkxFXyGwW4g96TgFFLDJhhyYuAi850p64OjQ@mail.gmail.com>
References: <20150224220923.GA23344@peff.net>
	<CAEcj5uV7XpXZTEyDrubXfWoN5uYn5BJbGaMbrWrmXbmgiCOHqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 21:09:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfCOK-0003K6-6b
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 21:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbbDFTI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2015 15:08:56 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33819 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbbDFTIy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 15:08:54 -0400
Received: by iedfl3 with SMTP id fl3so32686281ied.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 12:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yu+KGkNttLoi8nOjmBellon/11lDJ506u/Id0IIBXvw=;
        b=FX/qjhhNEX3MA3cDwfEMPHof/YWPmaH8zvcH6iAasUXGvmBqwnTDZkaH15znH4mmRc
         /T49w0SDU0RoEQfVSejbmUgEIJhtqwbzRYm5PM+Wg0Wit8OJGH2cPQRF6Pyo5fSLE0sp
         CTlVBGCXRzK55lYG9kPYtDhxFkhXt2E26SZ3V5h/rzCojoBPWN2cEQglmOG3bYgysxJO
         pafGq4m8dPO+2hofr1bAzdXN7gexicE9f1/XA4H568mCdH3ygTOo+e2/6ZtEklcprX18
         e0GH+MtHe8M627T+eoqqljq3qSgGIa3VmzcuThI32koVCYIf0+y9mkiAWxAkYo/YBuQy
         4iyA==
X-Received: by 10.42.21.16 with SMTP id i16mr3658125icb.54.1428347334258; Mon,
 06 Apr 2015 12:08:54 -0700 (PDT)
Received: by 10.50.245.168 with HTTP; Mon, 6 Apr 2015 12:08:54 -0700 (PDT)
In-Reply-To: <CAEcj5uV7XpXZTEyDrubXfWoN5uYn5BJbGaMbrWrmXbmgiCOHqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266878>

On Mon, Apr 6, 2015 at 12:48 AM, Thomas Ferris Nicolaisen
<tfnico@gmail.com> wrote:
> On Tue, Feb 24, 2015 at 11:09 PM, Jeff King <peff@peff.net> wrote:
>> I wanted to make one more announcement about this, since a few more
>> details have been posted at:
>>
>>   http://git-merge.com/
>>
>> since my last announcement. Specifically, I wanted to call attention to
>> the contributor's summit on the 8th. Basically, there will be a space
>> that can hold up to 50 people, it's open only to git (and JGit and
>> libgit2) devs, and there isn't a planned agenda. So I want to:
>>
>>   1. Encourage developers to come. You might meet some folks in person
>>      you've worked with online. And you can see how beautiful we all
>>      are.
>>
>>   2. Get people thinking about what they would like to talk about.  In
>>      past GitTogethers, it's been a mix of people with prepared things
>>      to talk about, group discussions of areas, and general kibitzing.
>>      We can be spontaneous on the day of the event, but if you have a
>>      topic you want to bring up, you may want to give it some thought
>>      beforehand.
>>
>> If you are a git dev and want to come, please RSVP to Chris Kelly
>> <amateurhuman@github.com> who is organizing the event. If you would like
>> to come, but finances make it hard (either for travel, or for the
>> conference fee), please talk to me off-list, and we may be able to help.
>>
>> If you have questions, please feel free to ask me, and I'll try to get
>> answers from the GitHub folks who are organizing the event.
>>
>
> I'll be arriving around 11 am on the 8th, if anyone wants to record
> something for the GitMinutes podcast [1]. Send me an email directly,
> or just walk up to me at the conference and say hi! I'll hopefully be
> hanging around the contributor's summit area with some microphones,
> but I've been unable to get any feedback from GitHub about whether
> this is OK, so.. I guess we'll just wing it when I get there.
>
> [1] http://www.gitminutes.com/

By the way as far as I know nothing has been planned for the
Contributors Summit on the 8th.
Maybe we could list some topics that we could discuss.

I will probably write very short articles about some of the
discussions for the next Git Rev News edition, but I would be happy if
other people would like to contribute some. Please tell me and Thomas
if you are interested.

Also I am not sure if something is planned for the evening of the 8th
or not. If nothing is planned maybe we could discuss having dinner
together or something.

And if someone needs help or arrives in Paris early or leaves late and
is interested in meeting up, feel free to contact me.

Best,
Christian.
