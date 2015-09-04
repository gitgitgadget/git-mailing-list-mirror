From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Do you plan to release 2.5.2 any time soon?
Date: Fri, 04 Sep 2015 09:08:13 +0200
Organization: gmx
Message-ID: <4fe75c9abad6fea816812beba72988fc@dscho.org>
References: <alpine.DEB.1.00.1509030038460.16897@s15462909.onlinehome-server.info>
 <xmqqbndjjpk5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 09:08:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXl6k-0000fx-SV
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 09:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758076AbbIDHIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 03:08:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:65485 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758064AbbIDHIS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 03:08:18 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MfBsk-1ZIre018Ty-00OlLI; Fri, 04 Sep 2015 09:08:14
 +0200
In-Reply-To: <xmqqbndjjpk5.fsf@gitster.mtv.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:l5UhnxacOcoei5dSfoahXKW+oIEugp2zoQPjMsVuj5NfQ5zYPLc
 dlppK3pczXJu+0xIY3IFyxffOQxyoopZZqw2LEoM8hQn8jIE0pK5qJWKO+ODiAs/2wEAArx
 4A++w3oxIbUSUjfptiD8qLQrTZ/ssUaw0I5OHiUGQ9q57zNbbSqz/k7e1+RIy58+hdlxWw4
 060PmkyiVFMG28GsOF+Ug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EmCkZlfWaN4=:LanPrgk9yzmcUwsgcMoX3P
 mEnP2wHvHu65Rr3U7GardZ9iIY0C9nvIs0DK7chHqV1JNpoTPRE8n9yspe0lFK7w3p6zLXtgx
 CtwLnF6s5toVN3b5/0iTdzkCZXzc20JBKF5MtDP4l/X3W2ac2Yn2LP18l6SqTt7T6cMn310+U
 4+rDjfGODrfnGJeDBG2zvtXFCmeuOfDzxRjbxToNHAvQqVR6TXDkokUpT8d5eraGwHvlj1xGP
 9ry436SA75ggjXlv/eVH851RAoVaeEFdq5Q3Z8RDQk5Zty68+fK/kTwZ4mXm0icxshGPqHmNM
 qBQdRhisuR3GOVSnk3qCsF5ptafE4nh6QkJJdalTIEUQE7dE+Ds8cEgE4KIppDW0t+0bTHKRw
 BXXql8pNqJdq3nPDvz4L7uqpAePWvkT8yiM2Xsp6FF7T+WJ9DcFGrswF0DR/8CjMMEQZAsWmb
 teJnDpFa+tCf3FKH/HiabpCXM9Y67side1SNEN4tKKWos8WpxKalZ+eNZSwCb/tAHhOyLu4SQ
 rhcdQVSbOxqbWVZtQE3GhIr73tzoh5zJuus38PHw+CL0jluW6dNVVq/9vJSSDvprDiPzyEBgY
 tHPR6TvYqFxl+vAVEiWmCeNkhqcw7UOBcB8h0dc31smTunWVc7a8BkbGFWmB6azQ1U59ucSpf
 T5CHy6XLMS0qnUDBqJQnFoTiPMnH1Rmk0zBEsJzvhhhDQBsJnXHkDVaV0/y0l68P7KaO7huU6
 37ZtHtGTQJLm3zD7gRsSlxc6qGsMBZfhW3H2rA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277290>

Hi Junio,

On 2015-09-03 21:00, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> I have a couple of fixes lined up for bugs in Git for Windows 2.5.1. Do
>> you plan to release 2.5.2 any time soon? If yes, I would hold off,
>> otherwise I will just do a Git for Windows 2.5.1 (Rel 2).
> 
> Among the topics marked for possible later merging to 'maint' in the
> draft release notes to 2.6, candidates for future maintenance
> snapshots are:
> 
> * mh/get-remote-group-fix # 4 (2 weeks ago) 
> * cb/open-noatime-clear-errno # 1 (9 days ago) 
> * jk/long-error-messages # 2 (9 days ago) 
> * jh/strbuf-read-use-read-in-full # 1 (9 days ago) 
> * ps/t1509-chroot-test-fixup # 2 (2 weeks ago) 
> * sg/help-group # 1 (8 days ago) 
> * nd/dwim-wildcards-as-pathspecs # 1 (9 days ago) 
> * jk/fix-alias-pager-config-key-warnings # 1 (3 days ago) 
> * jk/rev-list-has-no-notes # 1 (3 days ago) 
> * nd/fixup-linked-gitdir # 1 (2 days ago) 
> * as/docfix-reflog-expire-unreachable # 1 (8 days ago) 
> * sg/t3020-typofix # 1 (8 days ago) 
> * po/po-readme # 1 (8 days ago) 
> * sg/wt-status-header-inclusion # 1 (8 days ago) 
> * ss/fix-config-fd-leak # 1 (8 days ago) 
> * jc/calloc-pathspec # 1 (8 days ago) 
> * rs/archive-zip-many # 3 (2 days ago) 
> * dt/commit-preserve-base-index-upon-opportunistic-cache-tree-update #
> 1 (2 days ago)
> * cc/trailers-corner-case-fix # 3 (22 hours ago) 
> * jk/log-missing-default-HEAD # 1 (22 hours ago) 
> * ee/clean-test-fixes # 1 (22 hours ago) 
> 
> These I deem are safe (not just the changes themselves are trivially
> correct but it is unlikely to make things gravely worse if it turns
> out there were ramifications no reviewers thought about with them)
> and can go in 2.5.2.
> 
> As to other topics that are in 'master' but not in the above list, I
> do not have doubt about their value (otherwise they would not be in
> 'master' in the first place), but either they are still too young in
> 'master' or are with sufficiently big impact on the callchain that
> it is not entirely implausible that they have risks of unforeseen
> ramifications and fallouts.
> 
> Let's aim to tag 2.5.2 soonish, before mid next-week at the latest.

Okay!

Thank you,
Dscho
