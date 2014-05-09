From: Fabio D'Alfonso <fabio.dalfonso@fabiodalfonso.com>
Subject: Re: t5539 fails on ubuntu for v2.0.0-rc2 - the SAME on 12.04 server
 - this test was disabled up to 1.9.2
Date: Fri, 09 May 2014 10:39:32 +0200
Organization: Fabio D'Alfonso
Message-ID: <536C9444.8060408@fabiodalfonso.com>
References: <536A8FF8.7080909@fabiodalfonso.com> <536BF8C7.6010208@fabiodalfonso.com>
Reply-To: fabio.dalfonso@fabiodalfonso.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 11:01:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiggJ-00009x-1T
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 11:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267AbaEIJBW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 May 2014 05:01:22 -0400
Received: from gateway05.websitewelcome.com ([67.18.16.77]:45704 "EHLO
	gateway05.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753922AbaEIJBU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2014 05:01:20 -0400
X-Greylist: delayed 1301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 May 2014 05:01:20 EDT
Received: by gateway05.websitewelcome.com (Postfix, from userid 5007)
	id 6141254F6EB92; Fri,  9 May 2014 03:39:37 -0500 (CDT)
Received: from gator4050.hostgator.com (gator4050.hostgator.com [192.185.4.61])
	by gateway05.websitewelcome.com (Postfix) with ESMTP id 543F954F6EB60
	for <git@vger.kernel.org>; Fri,  9 May 2014 03:39:37 -0500 (CDT)
Received: from [95.235.186.180] (port=14898 helo=[192.168.1.16])
	by gator4050.hostgator.com with esmtpa (Exim 4.82)
	(envelope-from <fabio.dalfonso@fabiodalfonso.com>)
	id 1WigLA-0002Yn-Nr
	for git@vger.kernel.org; Fri, 09 May 2014 03:39:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <536BF8C7.6010208@fabiodalfonso.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4050.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - fabiodalfonso.com
X-BWhitelist: no
X-Source-IP: 95.235.186.180
X-Exim-ID: 1WigLA-0002Yn-Nr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.16]) [95.235.186.180]:14898
X-Source-Auth: fabio.dalfonso@fabiodalfonso.com
X-Email-Count: 1
X-Source-Cap: ZGFsZm9uc287ZGFsZm9uc287Z2F0b3I0MDUwLmhvc3RnYXRvci5jb20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248538>

Hi,
this test was disabled up to 1.9.2 so it did not fail as it did not run=
=20
by default.
I have set the variable to run and got an error also in previous=20
version, while never had problem in use.

So I simply go on as there will no worst than before.

It seems that no one is interested to this issue. Probably I=20
misunderstood the purpose of the list.

Regards

=46abio D'Alfonso
'Enabling Business Through IT'
cell.  +39.348.059.40.22 ***
web: www.fabiodalfonso.com <http://www.fabiodalfonso.com/>
email: fabio.dalfonso@fabiodalfonso.com
<mailto:fabio.dalfonso@fabiodalfonso.com>linkedin:=20
www.linkedin.com/in/fabiodalfonso <http://it.linkedin.com/in/fabiodalfo=
nso>
twitter: www.twitter.com/#!/fabio_dalfonso=20
<http://www.twitter.com/#%21/fabio_dalfonso>

fax: +39.06.874.599.581
BlackBerry=C2=AE Wireless Enabled Address.


          ** Hidden  numbers are automatically rejected by the phone*

On 5/8/2014 11:36 PM, Fabio D'Alfonso wrote:
> Hi,
> strange that no one gets the error. I get also on another server=20
> 12.04.4 LTS so the problem is not on a single VM or version.
>
> No idea?
>
> Fabio D'Alfonso
> 'Enabling Business Through IT'
> cell.  +39.348.059.40.22 ***
> web: www.fabiodalfonso.com <http://www.fabiodalfonso.com/>
> email: fabio.dalfonso@fabiodalfonso.com
> <mailto:fabio.dalfonso@fabiodalfonso.com>linkedin:=20
> www.linkedin.com/in/fabiodalfonso=20
> <http://it.linkedin.com/in/fabiodalfonso>
> twitter: www.twitter.com/#!/fabio_dalfonso=20
> <http://www.twitter.com/#%21/fabio_dalfonso>
>
> fax: +39.06.874.599.581
> BlackBerry=C2=AE Wireless Enabled Address.
>
>
>          ** Hidden  numbers are automatically rejected by the phone*
>
> On 5/7/2014 9:56 PM, Fabio D'Alfonso wrote:
>> Hi,
>> I am getting this in Ubuntu, something wrong with my env?
>> Thanks
>>
>> root@HDUBVM01:~/builds/git/t# ./t5539-fetch-http-shallow.sh
>> ok 1 - setup shallow clone
>> not ok 2 - clone http repository
>> #
>> #        git clone --bare --no-local shallow=20
>> "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
>> #        git clone $HTTPD_URL/smart/repo.git clone &&
>> #        (
>> #        cd clone &&
>> #        git fsck &&
>> #        git log --format=3D%s origin/master >actual &&
>> #        cat <<EOF >expect &&
>> #    7
>> #    6
>> #    5
>> #    4
>> #    3
>> #    EOF
>> #        test_cmp expect actual
>> #        )
>> #
>> not ok 3 - no shallow lines after receiving ACK ready
>> #
>> #        (
>> #            cd shallow &&
>> #            for i in $(test_seq 15)
>> #            do
>> #                git checkout --orphan unrelated$i &&
>> #                test_commit unrelated$i &&
>> #                git push -q "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
>> # refs/heads/unrelated$i:refs/heads/unrelated$i &&
>> #                git push -q ../clone/.git \
>> # refs/heads/unrelated$i:refs/heads/unrelated$i ||
>> #                exit 1
>> #            done &&
>> #            git checkout master &&
>> #            test_commit new &&
>> #            git push  "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" master
>> #        ) &&
>> #        (
>> #            cd clone &&
>> #            git checkout --orphan newnew &&
>> #            test_commit new-too &&
>> #            GIT_TRACE_PACKET=3D"$TRASH_DIRECTORY/trace" git fetch=20
>> --depth=3D2 &&
>> #            grep "fetch-pack< ACK .* ready" ../trace &&
>> #            ! grep "fetch-pack> done" ../trace
>> #        )
>> #
>> httpd (pid 10653?) not running
>> # failed 2 among 3 test(s)
>> 1..3
>>
>
> --=20
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
