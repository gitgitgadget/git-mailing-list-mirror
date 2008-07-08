From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Tue, 8 Jul 2008 19:22:46 +0200
Message-ID: <200807081922.48010.jnareb@gmail.com>
References: <200807080227.43515.jnareb@gmail.com> <19b271a20807080931w75430148u8c9778117c9fb6cc@mail.gmail.com> <alpine.DEB.1.00.0807081745040.18205@racer>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Joshua Roys <roysjosh@gmail.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 08 19:24:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGGuy-0005cR-AI
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 19:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbYGHRW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 13:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752276AbYGHRW5
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 13:22:57 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:43418 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbYGHRW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 13:22:57 -0400
Received: by py-out-1112.google.com with SMTP id p76so1257457pyb.10
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 10:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Y3l/wl9EW9u/r+DO8g4dEf4dZ1PFlM0EyrW0au6LrsQ=;
        b=OIICtgiMHCfuBkF8b/4nORjtckQ/pbPCDxegGwaOPloCTlwgLOOZI7uEwqBB9g/+ZN
         dOkCq2FINgVnp9PWLs03m+piYlcwI5rZwFyOgNhKc7ESs+90E9wX2Ki1eRqr4DhDSpU6
         IDdifCYkR8Ah2UKiYMZRWCGrsGqAwGaW/T3oM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=itVOzlm+6S3ihb1dWFG/R2yjLyboV5dYDMqp3T2OHH5Qyp8YwWtvPV8xor3lseGkDh
         uIe5U7RP+Lkey/fCSwfUSd614Y1KuPPLyhJES+C9WOHCQrSynt5pKKwUqvoEm4t/VdWy
         Oni3ykoLPBq3r6LvpqUCo3PsZczx7gmNDw4BM=
Received: by 10.64.196.9 with SMTP id t9mr1889346qbf.33.1215537773923;
        Tue, 08 Jul 2008 10:22:53 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.205.145])
        by mx.google.com with ESMTPS id k7sm7989142qba.3.2008.07.08.10.22.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jul 2008 10:22:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0807081745040.18205@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87774>

Johannes Schindelin wrote:
> On Tue, 8 Jul 2008, Joshua Roys wrote:
>> On Mon, Jul 7, 2008 at 8:27 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> 1. GitTorrent (???)

>>> There was short thread of me asking about project
>>>  http://thread.gmane.org/gmane.comp.version-control.git/83611
>>> where I got gittorrent mailing list [...] and URL
>>> for project repo / gitweb... which is currently down, so I cannot check
>>> if there is anything here.

[cut]
>> 
>> The gitweb randomly gives 500/internal server errors, not sure why.

(I think it was web server error, as error message didn't look like
it was coming from gitweb; besides gitweb up to some time ago didn't
use "500 Internal Server Error" HTTP error status code.)

> I thought you were working on the torrent stuff?  What is the status on 
> that?

I think Jushua was referring here to the fact that gitweb for
GitTorrent project repository[1] is sometimes down (it was down
when I was writing initial email in this thread).

[1] http://utsl.gen.nz/gitweb/?p=VCS-Git-Torrent
-- 
Jakub Narebski
Poland
