From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v6 01/10] t0027: Make more reliable
Date: Sun, 24 Apr 2016 05:45:08 +0200
Message-ID: <571C4144.2080701@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
 <1461335908-5013-1-git-send-email-tboegi@web.de>
 <xmqqbn51nvwt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, tboegi@web.de
X-From: git-owner@vger.kernel.org Sun Apr 24 05:45:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auAzA-0003pa-Ja
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 05:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbcDXDpX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Apr 2016 23:45:23 -0400
Received: from mout.web.de ([212.227.15.3]:62445 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066AbcDXDpX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2016 23:45:23 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MRzYo-1bItuK1cmw-00THFL; Sun, 24 Apr 2016 05:45:14
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.2
In-Reply-To: <xmqqbn51nvwt.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:fXd3exjnVwtfANw6f7dJ/fj8PHBl2g3i2r8oXMpHNwvs2AH7lei
 8HRTzwObDqBYeAO4z8TyWxinqYUxekmy/8hi2qV5IK+PHoSoqEmE5HdyLaYoC73oPkwwwH5
 wCSwxIRWzegyW4k0PO+WwxDEiSlbORBUpr/kYWQu+Sj+J5BBWuzH75acAcC0sMwh2GHr/Pa
 VccJ6WfTt2wyUlQq/agjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:On5V1Xv2vII=:LlmMVHvaHMqpQJ+kQE46Aq
 8meqbXiEToUQIe7zt4CfUBfncA+OgTrfxFMAhr6ogjhtPRStkt+2hSCKpXKLSTkMJD9eOtG5C
 Ds19SCozOlK/CDnevmQHP1/t6iDI+pq3n62Bec72S/5WxRJEAsJZG2aM8ncE09qv6r3rNeenH
 fxcZFHLzvrGXJoMq9iVQuOTZKCp9PMJhxRalNbJhDF0YT8vJLAtLELidjUPH6pjh0HRXdo8Up
 36bA5RqVRbCNU3q72TKWXddgw6mHBbL4tz6Grt0sewqQ0f1ry72fEdpk8C+9/6C56w5HUEbTm
 UNzcaszbwYhdnL6KTirRQN8hotdoaIwzlBcuJbp5ZsIMApLaSY10i2e6BG4k3yxSGLCbH2mbc
 5SibAfuJlDTv0D++epuaDpUFNsAn38qLZ5m0pvO4lipHFnlqnRRWIwyaExeL9BxjruwsPz8yC
 euidgmMhJv562khVC5qavioDUjyjUXbCL5Gk24c1XqZ5KTQOHUKKXg4sI0WtRNZUN0LI8OQ8p
 iqLdM0zHLpO7cWtGPTSwIbpy8tt09tobCD4OhZH+u2rqzfnVmtjrT/94bGty/06jkMj4oZ2d8
 01eB7KlXnMBy+yfvIQlKqfPy+XEX5LK4wIkPIxK+XyfToThCE72RDPR87IUG4h4F5A9E6fL0T
 b+zYXp1Ovl0/b7sOYF0eG06kqWmN80U1u3uQChw/vxGoNsUZfF0A7K6lfUeCP3C8wKG6pInXJ
 TVScERCVwEw56sBcmg68beSypCBHo7DXS/EcbmAScEfPCf+kUtJqb26VTicZ5R7kNZGNZw8m 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292310>

On 2016-04-23 00.03, Junio C Hamano wrote:
> tboegi@web.de writes:
>=20
>> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>> Subject: Re: [PATCH v6 01/10] t0027: Make more reliable
>=20
> "Make more reliable" does not sound very grammatical.
>=20
>> Make the commit_chk_wrnNNO test in t0027 more reliable:
>=20
> Neither is the colon at the end.
>=20

After Re-reading the series (with fresh eyes)
I found more spelling errors, typos in different commit messages.
9/10 is missing the SOB.
How about this for 1/10:

Subject: [PATCH v6 01/10] t0027: Make commit_chk_wrnNNO() reliable

When the content of a commited file is unchanged and the attributes are=
 changed,
Git may not detect that the next commit must treat the
file as changed.
This happens when lstat() doesn't detect a change, since neither inode,
mtime nor size are changed.

Add a singe "Z" character to change the file size.
Ignore it when comparing the files later.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
