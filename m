From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [PATCH 14/14] Add README and gitignore file for MSVC build
Date: Sun, 23 Aug 2009 20:59:11 +0200
Message-ID: <4A91917F.9000709@gmail.com>
References: <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>	 <1e623b19b2df001919c83418fef89ef04d7b8dfe.1250860247.git.mstormo@gmail.com>	 <74ca14c3a691cc9844a0dd806f5db47977317bdb.1250860247.git.mstormo@gmail.com>	 <4b8b550914cfc4e638ff905d9b9aa416e45913f4.1250860247.git.mstormo@gmail.com>	 <ba4e68ae32784d8e0c706fa665fbdbbfe67ce673.1250860247.git.mstormo@gmail.com>	 <6dd71f163e5410e401fc66088405736d1978ec55.1250860247.git.mstormo@gmail.com>	 <cover.1250860247.git.mstormo@gmail.com>	 <54673ddb6bef681194e141e5e05e930cdfaa07bc.1250860247.git.mstormo@gmail.com>	 <e82f1930173966ebb6b2d2815e037a26e079f969.1250860247.git.mstormo@gmail.com>	 <a4c8a6d00908230926of0ea10bhd8f66e7d37c3b39b@mail.gmail.com> <3f4fd2640908231122m34604196pc98c5871cf5925b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thiago Farina <tfransosi@gmail.com>, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 20:58:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfIGe-0004op-7c
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 20:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933766AbZHWS6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 14:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933739AbZHWS6F
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 14:58:05 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:52175 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933724AbZHWS6E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 14:58:04 -0400
Received: by ewy3 with SMTP id 3so1845046ewy.18
        for <git@vger.kernel.org>; Sun, 23 Aug 2009 11:58:04 -0700 (PDT)
Received: by 10.211.196.6 with SMTP id y6mr4177707ebp.61.1251053884422;
        Sun, 23 Aug 2009 11:58:04 -0700 (PDT)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206])
        by mx.google.com with ESMTPS id 28sm2668805eye.35.2009.08.23.11.58.03
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 23 Aug 2009 11:58:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <3f4fd2640908231122m34604196pc98c5871cf5925b5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126864>

Reece Dunn said the following on 23.08.2009 20:22:
> 2009/8/23 Thiago Farina <tfransosi@gmail.com>:
>> Hi,
>>
>> On Fri, Aug 21, 2009 at 10:30 AM, Marius Storm-Olsen<mstormo@gmail.com> wrote:
>>> From: Frank Li <lznuaa@gmail.com>
>>>
>>> +3. Open gitbuild\gitbuild.sln with VS2008. Then press F7.
>> F7 does nothing in VS2008, to build the solution you have to press
>> Ctrl+Shift+B. To build and start debugging you have to press F5, and
>> for start without debbuging support is Ctrl+F5.
> 
> IIRC, Visual Studio can be configured to use different keyboard shortcuts.
> 
> However, saying "press F7" says nothing of the intent. It would
> probably be better to have this say something like "Then build the
> solution." or "Open gitbuild\gitbuild.sln with Visual Studio 2008,
> then build it." But then you don't need to open Visual Studio 2008 to
> build it (you can build it from command line).
> 
> So, how about:
>    3. You can now build git with Visual Studio 2008 using the
> gitbuild\gitbuild.sln file.
> 
> - Reece

Agreed.
Thanks guys.

--
.marius
