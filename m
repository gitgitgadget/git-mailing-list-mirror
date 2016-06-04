From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Jun 2016, #01; Thu, 2)
Date: Sat, 4 Jun 2016 16:51:28 +0200
Message-ID: <1e3801ae-742f-61c4-2b72-350ada0b2220@web.de>
References: <xmqq4m9aqn4d.fsf@gitster.mtv.corp.google.com>
 <20160603232653.GA24538@glandium.org>
 <xmqqvb1pzvfu.fsf@gitster.mtv.corp.google.com>
 <20160604051458.GA3149@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 16:52:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9CwB-0001kY-FM
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 16:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbcFDOwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2016 10:52:07 -0400
Received: from mout.web.de ([212.227.15.4]:64069 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887AbcFDOwG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2016 10:52:06 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MUWCB-1b01p72SbD-00REqJ; Sat, 04 Jun 2016 16:51:34
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
In-Reply-To: <20160604051458.GA3149@glandium.org>
X-Provags-ID: V03:K0:sQlL8CGiE4rUNb/Of5C8eEspuxHCqLWXVXhg/736CuF7Rc3kY39
 Ol0ci4gJOZgiAPDb+pEs3zR/lnN3q9vyBwu89a+CGrUbcrUNxMGeJ5TXyM3JWfLOb82/909
 XJkOCPRHZvjxdxEz3e3pGHbfdVGF6LXq/Szlu/M0Rp0zlmSwvig3i6yZwIfWUB4OecquAGN
 WjRu27/H7OsUlPsROMv8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SX/pqnMph0U=:zXHM4nU6ymR9C5m6ajr+ND
 7ZENoSVO0nYUWFrhf1bgWAzyq9wIqR0lWxXh+W3kNwReXqOGc6/BHyN+r7nJ6cXf85VCQuQg7
 CKKETTwCGX8CR6xRQvyqnzpuDR5TYj9jfy9cpM+BeM0qB4dganJzfEAj+7EyMopfzfee8wP9o
 1+BOndvIQi0bD0zBDkj5aToudc0FUnqocOBWblmPYn1hIUCqSJBEvKdGKML5yPLF05ELP8k1i
 U0QT+ouG13nCCtk8VtOAWdrzw1i52mDTDcZg4DwPyhLrMGEBt7NnumvvQt+4O/mSxO+1Yr/6M
 K3xH8Y+le2hjm5kHnHzLvLggcfXn5MtKZ6lvWHtWghsF9qaFw698V5iN/gX6R6jD6Zua/8Kfu
 Ibne1z9CjRV4Wv31G4/54C3j2m7eecDl7/aZSNNlfMUP6BvvgyPJ4UMAus6q/W1e8ic3ohU8y
 jLnEaERQO5Bf7Vyr+rpUGxK8JOPtRrTkN+j7Q6X8vQJj58tDEokeExmTlV7DwO3ILsRUtH/zh
 VrVKK61YhfoTf/53umhGXgoTvS5ju9JwNNr4qhDk/tj+POOM1A/KKDe/d+ecmGSbLqRq7KSKN
 yftV+kcGoDQUbXoh9thm8iY+U+McKH8AGV/gI7AyCbZbzlQ7p9Y5hQAXU2CjWO9Upt5345qTv
 iuV+aUYxaWpHhRRs4ymVkVsrZZAHOa/zqgTkW+rP7dduZBzUmwg2um9We0YpfGXeJQUNVCDkS
 zFMy160QWqADfNWOY63vbTXnM3WMVidTZnmhJRmucxm9YoLrB3DwbBo7Km5lZizE3moPnNUn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296444>

On 2016-06-04 07.14, Mike Hommey wrote:
> On Fri, Jun 03, 2016 at 04:47:33PM -0700, Junio C Hamano wrote:
>> Mike Hommey <mh@glandium.org> writes:
>>
>>> In fact, the parser doesn't even reject the one that is considered
>>> invalid (the first).
>>
>> My question was what the desired behaviour is, and if your "fix"
>> gives us that desired outcome.
> 
> From my POV, the desired outcome from this patch series is that there is
> no change of behavior, and Torsten's fix makes
> git://[example.com:123]:/path/to/repo urls handled the same before and
> after the patch series.
> 
> Whether that's the desired behavior is another topic, that we can,
> IMHO, leave for later.
This is the old behavior:

 GIT_TRACE=2  git clone -v git://[github.com:9418]:/tboegi/emacs.d.git $$
16:32:28.692918 git.c:350               trace: built-in: git 'clone' '-v'
'git://[github.com:9418]:/tboegi/emacs.d.git' '95214'
Cloning into '95214'...
Looking up github.com:9418 ... fatal: Unable to look up github.com:9418 (port
9418) (nodename nor servname provided, or not known)
# Everything inside [] goes into the host part (good),
# At the same time :9418 is printed as the port (weird)

This is the new behavior:
GIT_TRACE=2  git clone -v git://[github.com:9418]:/tboegi/emacs.d.git $$
Connecting to github.com (port 9418) ... 192.30.252.122 done.
or
GIT_TRACE=2  git clone -v git://[github.com:9418]/tboegi/emacs.d.git $$
Connecting to github.com (port 9418) ... 192.30.252.122 done.

In any case, everyting inside the [] should go into the host part,
for all protocols that have a scheme.
But.
There is a little but.
the ssh protocol did, in early days, not parse
ssh://user@[::1]/path/to/repo correctly :-(
The only workaround to use a user name with hostname in [] was
to use
ssh://[user@::1]/path/to/repo

The thing I'm asking is, if we should handle

git://[github.com:9418]/tboegi/emacs.d.git
or
git://[github.com:9418]:/tboegi/emacs.d.git
the same as
git://github.com:9418/tboegi/emacs.d.git
