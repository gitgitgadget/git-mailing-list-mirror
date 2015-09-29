From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] git-send-email.perl: Fixed sending of many
 changes/patches
Date: Tue, 29 Sep 2015 17:43:25 +0200
Organization: gmx
Message-ID: <e6d296ecf9f32f74c709714ca0de14ba@dscho.org>
References: <1443538820-20023-1-git-send-email-polynomial-c@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, juston.h.li@gmail.com,
	Stefan Agner <stefan@agner.ch>
To: Lars Wendler <polynomial-c@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Sep 29 17:44:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zgx4Y-0003c8-JC
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 17:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934745AbbI2PoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2015 11:44:00 -0400
Received: from mout-xforward.gmx.net ([82.165.159.12]:61861 "EHLO
	mout-xforward.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933499AbbI2Pnh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 11:43:37 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M5Lqx-1aahVJ0l8p-00zY4c; Tue, 29 Sep 2015 17:43:26
 +0200
In-Reply-To: <1443538820-20023-1-git-send-email-polynomial-c@gentoo.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:+1CXmmyOB1CbvyDNG6Vct28Obh0czlqDFFef6mKIjFgAx10PuAw
 KoRXWuHfqukGb7LIzOe/5XOC+eMyfFEtaaQpPK8IH2CXIw4c5+CGKfzLdPX4S6yoSeJ6Bpp
 UhzgCyTu7XIMF32WMb5b1RzLpVN5HlvZpLdS+pDM1GjOTNiFeUhzo4CerB9+o/n0TDxSDXP
 b4UfjGOLNJc4ktn1hqhJw==
X-UI-Out-Filterresults: junk:10;V01:K0:KGpBcKzW9Ig=:21ymzk0B3AKDlzkpFDDqjZMV
 1E0rHXv0AFA9fP3NTU3//MWr/OA+tBRnVg579PuVbbmHTLPOVxMbDsWbcRT4evG9YPXDa4P/5
 4ksSKjcxhN8RQrIE8znRrrRz1fhzcCBWM2fnGRpz21GnoLRsl00nMOoQBr+wtFuZbIgKd3fC4
 IGStTP51KwzxyCVtT1kThuEGn0zmXVcepVfNmmx2OgaXa5ZFArOwLlHvXmCBdwQ5zpwQjvHG8
 EKololVnDO5oSuLEf9Ax6YfM3a6eZe1C3sxvuulDoH8RDbmkvyaGYJQs1ESYvIHjL61sY/I0/
 TsCSH9xRWdwIG3owC8mcBYw2aG7+gIBWg6uQBj2OkKYJ4/v38i79C7vwkKZZsrB+mBlLqPDwS
 HuEXndqFi6BXzYgt/0x7jdaYOTHzDdOdo5fPS0lgqItgBrCFB2IRVK82GPcfTzrR9Rj+mTb4F
 wwNeR5MaMJrQHMa4bpjTbp7tTKvlG79u/fbzVL67m8tmVH8Oh7eH9V0y297A4ziXkt0SCbbyT
 J0pWRCN5tdJ9EAgluA65ie0bnwd++RcvqFFeVT5GsbR0fD7PzXHkpEFXacCx8Pql5GzSvddWC
 G3vGgJ96h0eMv5hpHylew2axxSsIXmMhLCtRKEVjSjUccg49UB8snRwdtwvkRbpxWmjiE6wj9
 m9sQzJa1oI2kr+voBD89ZhpfrUDepJWi19FXjlxbR/5v4qNnQmBDKQZxS5wkicbAgPm5A1EJV
 us9jNAD5A1j+nKcChfocq5FdwZSHabYmPMFqssbZcdx+8c50LzHNGNe3P7n9O2ApQXRU7Geb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278827>

Hi Lars,

On 2015-09-29 17:00, Lars Wendler wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> See http://permalink.gmane.org/gmane.comp.version-control.git/274569

Please summarize the linked discussion in the commit message, as it is the convention here in the Git project to make commit messages self-sufficient, with links thrown in only to provide more context when desired.

Ciao,
Johannes
