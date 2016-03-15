From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/4] lib-gpg: drop unnecessary "missing GPG" warning
Date: Tue, 15 Mar 2016 20:33:39 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603152033140.4690@virtualbox>
References: <1457309427-30124-1-git-send-email-sunshine@sunshineco.com> <1457309427-30124-2-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 20:34:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afujA-0001JP-A8
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 20:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965698AbcCOTd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 15:33:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:55118 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbcCOTdz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 15:33:55 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MUYiV-1aGEbe3WOh-00RLQY; Tue, 15 Mar 2016 20:33:41
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1457309427-30124-2-git-send-email-sunshine@sunshineco.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:3Qk+mJwz1gOT9Y5jzP6LWLIM1FAi3VpvC9OagThEC6X//M/56Zw
 ZaQ2be69tOqUK/xj98yE0Az5rNYMfosiDsrZw6A491D6UTw3Mef4NMXenoI+TA8TzADF7sr
 lPIHeq+i8ui8V9Wc20BdraAm/8t26v7nogQIb9WyCc5Q/IcOuOApQ6EQJkmE2cNljJhOs44
 mQyRz8CDjQVFiYvVeRN6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DFMgw0Lz7vA=:wMu2XYMfUwAnikgGanFuKl
 gLmQBNnbRGJBROq5Awn5cdK6YLu7Zq/n7hAU1JjjSUTLWODNh3kaFD540YLDjPgG9HdeKdoVb
 Wq3VHvDMqsqt2hc8I6igiiqqe5vSIoqsXk89ukTA+XF6xRVyVFVjYLcc8adb89V6C1eUnz056
 VRX+UVZ7xQmDiMQAi2ov9xefDxA48sDJieM0bUjEpFqEREIOEbz0EVepE5jLxyrOtD/jeqqT/
 /xx0B9agfDHddf7jnByef+9vi/2K9rYdkm7psAbKD9QMQy0rVDMVLZ82l7t6sinnv/zMwOFla
 bmE4TUIljsnr5FxdRE1WJTsNmWkx/ynUiZZXnMTHGELTr/6d76VT5A/fEZYcZydPx5CisJlY6
 ElmhKuo20IFWTMlhmcfBhsYN4Qed863uqauYgWz0R6WVaWl3vb2jzQpBKMlhzFi/Nv799iKmM
 SXeSUe3wC2xUdSYYw4+QXa/qQ/8HkSlyYKPCD+nfpgavTXNGjHTYGpP19o3STBfWFO+MZAPzR
 KD4dRx39vRISp1NTfXaR4KjZ/52wZgd3VbdO+apwqNswWR5Ie7VgWiDHOlbALke6Wq3ql1npq
 FpSDBRFrSC+1DQ22tZbWebskg8TvF4QJlzH8nuc7hhwJHieSkvUoq1oE8slk08aj95t5J7DW5
 z0wWjvciV5F5XPl9qDsFRLFq0DhLvD6Nj+2MyjhmOjMmYk1hxPWR9YuCLc1Vyn2cFGtyeLlhh
 /+LJEJgFhLsOGVJiy359pu0ame6ZGuVBigjXeSw3kFLhv8NjBQgbhwYIomS12Qsiv4sOEDwe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288899>

Hi Eric,

On Sun, 6 Mar 2016, Eric Sunshine wrote:

> I also sneaked in a minor style cleanup.

Isn't this "snuck"?

The patch is fine.

Ciao,
Dscho
