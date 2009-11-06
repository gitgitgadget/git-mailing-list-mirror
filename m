From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: [QGIT PATCH/RFC]
Date: Fri, 06 Nov 2009 09:15:37 +0100
Organization: LyX
Message-ID: <4AF3DB29.6010908@lyx.org>
References: <4AF19630.2070402@lyx.org> <e5bfff550911050141t751d45a0r4e340fa0d10af366@mail.gmail.com> 	<4AF2A538.7040303@lyx.org> <4AF2A69F.1090802@lyx.org> <4AF2AAFD.9000309@lyx.org> 	<e5bfff550911051225s13c6e39dh355dc3ab1c0623f@mail.gmail.com> <e5bfff550911051227g257312b2idf729b9451d1bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 09:15:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Jz3-0003OU-PC
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 09:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbZKFIPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 03:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbZKFIPg
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 03:15:36 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:35553 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbZKFIPg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 03:15:36 -0500
Received: by ewy3 with SMTP id 3so805461ewy.37
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 00:15:40 -0800 (PST)
Received: by 10.213.0.216 with SMTP id 24mr485815ebc.10.1257495340414;
        Fri, 06 Nov 2009 00:15:40 -0800 (PST)
Received: from ?192.168.4.216? ([62.161.104.182])
        by mx.google.com with ESMTPS id 5sm5842640eyf.7.2009.11.06.00.15.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 00:15:39 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <e5bfff550911051227g257312b2idf729b9451d1bb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132281>

Marco Costalba wrote:
> On Thu, Nov 5, 2009 at 21:25, Marco Costalba <mcostalba@gmail.com> wrote:
>   
>> When I tested I _found_ a speed difference, but now I don't remember
>> of how much. Be sure you have warm cache when doing the test (press
>> F5) for few times to be sure all is in RAM.
>>
>>     
>
> Sorry, I forgot.  Be sure also our custom hashing function is actually
> called in your binary and the compiler didn't linked the Qt one
> instead :-)
>   

Yes I made sure of that (see my other mail).

Abdel.
