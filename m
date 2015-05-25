From: Alangi Derick <alangiderick@gmail.com>
Subject: Re: Suggestion to add a new command(git print-tree)
Date: Mon, 25 May 2015 17:25:46 +0100
Message-ID: <CAKB+oNtV44hoGzVE6F6=wu_JGy0N2C6B9S06nn92CYo6mGth0g@mail.gmail.com>
References: <CAKB+oNunwVEc+UJxXN0y5U1VMKsZTyjQ-1zr_bdJbd+tOKeTPQ@mail.gmail.com>
	<CAKB+oNtOXJO39QR2ZukMVM8juceBrBeiWLz92eVEOteVO99brA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 18:25:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwvCJ-00042N-U5
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 18:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbbEYQZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 12:25:47 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33720 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbbEYQZr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 12:25:47 -0400
Received: by qkgv12 with SMTP id v12so68106904qkg.0
        for <git@vger.kernel.org>; Mon, 25 May 2015 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=jK+9hLzgvpC4yRr+Ac2HhNEKo/mONMerw6lif2+hqdI=;
        b=d7zctFNLcuOkhmgeNSpaYZ3mpE8T7M+7L4Nkyb0gr1jZ6auMBurbj2o9WNDPGegeNu
         jeW3t3f8q6iXbGSsNggUKlWk18Uqomdal6RYtmHqN6jlDHQS4qR2MphfmWgyq7obqzJU
         1Vj7XqNlTJpYbra0dv59lufusiy2OVkR6Sa707d/wUdf+5IedvCBkL3NJcMsiFlY5LcQ
         MWX0N4WQGE+reraloKj3D7bk0z/7wY4dBCFvWHhHoSp7eHQRpfeygbjH2GyaADCrrXM4
         +88TLjhW/7cIB0FramOCe9H/ZFKMQwOWB+MnXNmqTYFJDGRu9ZYbR++9aCuwX++K/nNd
         N1Xw==
X-Received: by 10.55.40.218 with SMTP id o87mr45560732qko.82.1432571146398;
 Mon, 25 May 2015 09:25:46 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Mon, 25 May 2015 09:25:46 -0700 (PDT)
In-Reply-To: <CAKB+oNtOXJO39QR2ZukMVM8juceBrBeiWLz92eVEOteVO99brA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269843>

Regards
Alangi Derick Ndimnain


On Mon, May 25, 2015 at 5:21 PM, Alangi Derick <alangiderick@gmail.com> wrote:
> With discussions i have on the irc channel(#git) i just noticed there
> is the git ls-tree command but it doesn't format the tree so it will
> be a good thing for the tree to be formatted. I will like to embark on
> the project.
> Regards
> Alangi Derick Ndimnain
>
>
> On Mon, May 25, 2015 at 5:17 PM, Alangi Derick <alangiderick@gmail.com> wrote:
>> Hello everyone,
>>      I will like us to discuss on this topic to add a new command into
>> git that will enable us to print the entire working tree in a git
>> repository. Something similar to work happens when you run the linux
>> command: "pstree".
>>      This is important in searching and also more that i will be
>> discussing while talking about the idea. Thanks and if there is
>> anything to say about this, feel free to comment.
>>
>> Regards
>> Alangi Derick Ndimnain

Sorry for topping post, i forgot. Just like i said above, it will be
good that commands like; git ls-tree, git ls-files and more commands
of git that list directories to do them in a tree-like manner.
