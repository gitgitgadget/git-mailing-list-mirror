Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 350491F744
	for <e@80x24.org>; Mon, 20 Jun 2016 06:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbcFTGPH (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 02:15:07 -0400
Received: from mout.web.de ([212.227.17.11]:52764 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbcFTGPE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 02:15:04 -0400
Received: from [192.168.4.69] ([79.223.127.214]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M3jwL-1bW83K407l-00rJEp; Mon, 20 Jun 2016 08:06:25
 +0200
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
To:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
Message-ID: <18617acb-bcdb-607d-007e-552dabd352cb@web.de>
Date:	Mon, 20 Jun 2016 08:06:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:TDhmM5o4Zqc+gc2T+EGCEySQBX3uKWE+FZ54hWlM4U91tpNM9fn
 wjicXws2Ypiq6pek9duc374qSDtI8mcv3mGNhXjvsJAVl7OLN00/eXYfeWekSaJQpLW/8da
 6Q1+DfADmpp+w9AFzp8q+oNij4up6VGvdpUdXrIjrbwMZZBcE7oA9mPywn8Orkst0ovnkZu
 NWSBi7bCdW8pB6P0YBryQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:sEqxL4Mlvko=:qA7InSo3yTQSHNwvl1zPxi
 iqoTDju8Trz5Hqz1zlxjUkNB1Y57FhCskb+lSglWBx+birpGoRwJsQJAyXZBsLkw3sYUi5mj+
 tXGSG12m1FZqiUyuCBHjjMqIJr7O6zxfRojXioZPcPfT7lJJ9s/fMLBLKdL+bvhtaZKal2Zbl
 NaGR4FNxLQF/p8OKm9gcpyC3wQ09Lfv/IauEPtl1ezYWvXo7tnhYJ4sZ+iZ0c6PLWLiVPiWp+
 +3VvFYaXjGIw8u0HYjaLqTUazEPaTRb7nslIM9b0Xd1sGBJCV2t01NzvwdX6lLySNmIjBmOxv
 pviHrSLGT0AF/TyyDgND703B+jHOTP0WtqVpkq559/41h/NIYh/aZTjvTvNpB9t/5Y89z1ofy
 0Hqcua5AOS7snGhUnkfoVloVkqJQX82q6V226LliSUWZm5MdneFgEnCsvOXOBtQhbZzfT8ubY
 FqqGq8WtS7Kg0vYyNyHBd1bUZaCuGOgeGS0NhvrP4+6VkwrMa6jHxW2CoN+kBNcYP0m2BLffi
 Na5FL9+gcs1VHWTWfcPWdki0HBMg2QKB5P8gpMK8rrX7D6i9DuiCaM3nRrQm9HdvItYQg6uqE
 H55M/KGU39sRinF2bWp6n1ydQWmC6X9bPcOPDfGiPEkD1aCRwr72+O/PiYA+r6W+v+SrCPJ4c
 RlKpyLiOK/79HBp0O1ekzm4G/I3aBnzrqr3lfeZmNU57R+ZCagxgAbkgWw+XW5S7mHgU52DK5
 CqpFbFV+uKwM9guzL5KWnlKg4C44KPktom8CPLmrJQXhTf33/sfB/QwMbRsvqd7APLWOE2inr
 x+xXUu1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


There is a conflict in pu:
"jh/clean-smudge-annex" does not work together with "tb/convert-peek-in-index"

(And currently pu didn't compile)

(I will hopefully be able to do a separate review of the smudge/clean patch)

(And joeyh@joeyh.name is not reachable from web.de)

