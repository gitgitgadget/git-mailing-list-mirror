From: Jason King <jk@silentcow.com>
Subject: Re: am fails to apply patches for files with CRLF lineendings
Date: Sat, 13 Feb 2010 11:07:25 -0800
Message-ID: <A819F036-17D9-49C2-B3EC-85CFA27D30B8@silentcow.com>
References: <20091214183337.GA25462@atjola.homenet> <7vvdg9i9mn.fsf@alter.siamese.dyndns.org> <tCQlJn153g8Oa6Z9HKe6xOUQJdcf2PCIVthlTrLgYE-wJ5jFyXVXWw@cipher.nrlssc.navy.mil> <7vhbrtdtth.fsf@alter.siamese.dyndns.org> <F25E4EFA-BDD8-4920-96FC-2347AD5A3605@silentcow.com> <wtPFseZ4A1pT-STvrVsX7nC5hglK1gLCP4QZPtcSuvTN1jW0PYRUbQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Feb 13 20:07:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgNL7-00010c-2T
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 20:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757871Ab0BMTHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 14:07:32 -0500
Received: from mail-yw0-f179.google.com ([209.85.211.179]:54964 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757771Ab0BMTHb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 14:07:31 -0500
Received: by ywh9 with SMTP id 9so3456133ywh.19
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 11:07:29 -0800 (PST)
Received: by 10.151.88.17 with SMTP id q17mr5448664ybl.193.1266088049709;
        Sat, 13 Feb 2010 11:07:29 -0800 (PST)
Received: from ?10.0.111.20? (cpe-66-91-237-223.san.res.rr.com [66.91.237.223])
        by mx.google.com with ESMTPS id 16sm3308551gxk.15.2010.02.13.11.07.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Feb 2010 11:07:28 -0800 (PST)
In-Reply-To: <wtPFseZ4A1pT-STvrVsX7nC5hglK1gLCP4QZPtcSuvTN1jW0PYRUbQ@cipher.nrlssc.navy.mil>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139823>

Just noticed 1.7 was just tagged, so I thought I'd ping you guys about  
this CRLF issue in `am` again - squeaky wheel sort of thing.  Thanks :)

On Jan 5, 2010, at 8:41 AM, Brandon Casey wrote:

> Jason King wrote:
>> I just grabbed 1.6.6 and noticed that this problem still exists.  I  
>> just
>> wanted to ping this thread to make sure this hadn't been forgotten.
>
> I am interested in fixing this but have not been able to get to it.
>
> -brandon
>
