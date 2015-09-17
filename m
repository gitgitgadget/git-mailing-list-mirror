From: Stefan Beller <sbeller@google.com>
Subject: Re: On a personal note
Date: Thu, 17 Sep 2015 12:27:41 -0700
Message-ID: <CAGZ79kaL6Rmmm6siN1nY-OnqK4ij_oboGgeNHz2dqYC6BKb6jQ@mail.gmail.com>
References: <alpine.DEB.1.00.1509031156510.29350@s15462909.onlinehome-server.info>
	<CACsJy8AcK8hAkMowA0t5SusJDTYZDWZCFN5JDs2f-puZcJAfhg@mail.gmail.com>
	<a6ea2cc0231a0fc311b45b8d6edbd305@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, git-for-windows@googlegroups.com,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 17 21:27:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZceqR-0006X5-2X
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 21:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbbIQT1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 15:27:43 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36765 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbbIQT1m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 15:27:42 -0400
Received: by ykdt18 with SMTP id t18so26775781ykd.3
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 12:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Zg76waKDeNj8nF2Id3d2kKw7rpbliDrASfrwCOmeqrE=;
        b=mjkkeILDQlV0FML3zjNVGjBU6TFjUYOtcsRPBN7YjKCYVSh7YS9HwQ3vf3Fe67MfV7
         TMb4ziuCm1EJDSzBWtdCGgJXQ8paQvZwY6izwBQ57D6yTV7WrS6UqAMNt+dnISBQ+waV
         uwa4IeQySYJAHweIRGtgDXMB8VWZmRHQRVvGOm69O9KkBMp850wX2IQ8i3yRuf49w/Ld
         w94IFhWZs+ivHcZmKLCU57KhMTLpU9iy9fw4C3cDUHLrHfQuUKzMXBShnRHmHmhNaVU7
         yX+Brf2E/18BJFLsGghq/BeVf8NGGiLem/Yg0tsALeMxKwV+PYnDucUnG1bBJ89VbyI0
         xV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Zg76waKDeNj8nF2Id3d2kKw7rpbliDrASfrwCOmeqrE=;
        b=N99sNIATmB0ekHcSD6pdBOEmNQD/2J52OCttj+SohyFxtQvyK5c5RoqNen24AsLzXz
         RabMH+38uZo+MnEpwFPJqKKydlhSFo7Rk1mQj+NOVgXsD8ZxZ3YD6/vQx4PMhTSWbOoc
         u5uoiSEdZwk+zFRZBEPI86TN9TrM/rT+Gv2N53vbSuVPkPI36eTwhBn1gLW+stYpPGR7
         HFXK+FWvz0t9sX9AWbzRgwOQVVVg1rIqsVMhVX/bhnSqwylCiP4HpVrVvLynFQA0O50m
         U8FLQEJNDWtrBPwseo7IDnpCTeWCYgCQtUzmXJmdRa6SuOZh7xpAbjidCUNpoiZzw2XX
         2nRQ==
X-Gm-Message-State: ALoCoQkGXpigdSatiHV2GeJuacKEHOzL9FtGK5lNPIv2miNugPvbICIkZL7n/21R75Vg4amE8y1A
X-Received: by 10.170.190.133 with SMTP id h127mr897694yke.115.1442518061964;
 Thu, 17 Sep 2015 12:27:41 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Thu, 17 Sep 2015 12:27:41 -0700 (PDT)
In-Reply-To: <a6ea2cc0231a0fc311b45b8d6edbd305@dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278162>

On Thu, Sep 17, 2015 at 11:54 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Duy,
>
> On 2015-09-17 15:29, Duy Nguyen wrote:
>> On Thu, Sep 3, 2015 at 5:00 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>>
>>> yes, it is true: since mid-August I am working for Microsoft. Over a
>>> year ago, I got into contact with the Visual Studio Online group at
>>> Microsoft, of which I am now a happy member. A large part of my mission
>>> is to improve the experience of Git for Windows. This is very exciting
>>> to me: I finally can focus pretty much full time on something that I
>>> could only address in my spare time previously.
>>
>> Is upstreaming msysgit-specific patches in the roadmap? It would be
>> very nice to have everything in one tree (or at least keep the two
>> trees as close as possible).
>
> Please strike that name "msysgit" from your memory. Just remember "Git for Windows". (The name "msysgit" *never* referred to "Git for Windows", but only to the development environment used to generate Git for Windows 1.x). Please. Thank you.
>
> And yes, the roadmap is pretty clear from the GitHub tickets, e.g. this one:
>
> https://github.com/git-for-windows/git/issues/285

That's pretty awesome. Glad it's on the roadmap!

>
> Please note that I held off this week for three reasons:
>
> 1) I was submitting patches to the MSys2 and Cygwin upstream first,
>
> 2) I was busy fixing e.g. that bug where home directories containing non-ASCII characters were handled incorrectly (and generally trying to keep the tickets in https://github.com/git-for-windows/git under something similar to control), and
>
> 3) what with Peff's and Stefan's huge patch series, I did not want to overload Junio.

My patch series is not large by any means, but it seems as if it requires
lots of discussion in the fine details. ;)

>
> Please note that I already started submitting patches, though:
>
> http://thread.gmane.org/gmane.comp.version-control.git/277542
> http://article.gmane.org/gmane.comp.version-control.git/277731
>
> Ciao,
> Dscho
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
