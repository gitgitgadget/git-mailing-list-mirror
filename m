From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [GSoC update] Sequencer: Debating the UI
Date: Tue, 14 Jun 2011 13:45:51 +0200
Message-ID: <BANLkTinoWC8BcXy++xiWG=QWWcs-ZJBYYw@mail.gmail.com>
References: <BANLkTinxx5qFuhwsUt3JeXOO7TjBj8wFvw@mail.gmail.com>
	<20110614053143.GA24882@elie>
	<BANLkTikDq8DJeUde-jSPL2bKw1jk3GoYVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 13:45:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWS4D-0004s1-Od
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 13:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756236Ab1FNLpw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2011 07:45:52 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49815 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab1FNLpw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2011 07:45:52 -0400
Received: by gxk21 with SMTP id 21so3410159gxk.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 04:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cLwP0izwB8R0pCX8/FKizkjoDknXL9RAUWvvgWv1VXQ=;
        b=oStUnzrqRwnDB+KxvxnDFJQmI9qONGzQmcY7WyRzCPrmy6DNaQSOj56HVGHLgfs2Qs
         AG193drmyXnPT8KszGHqBhjOYjN6Rbnx3nm5OV9WeuxStFBVYfeZLgS3S8t3ctQ3TBox
         mviE2mcz4DJkcnQt3Y/sgyCRtPQUJMp4X6wyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nHxHoYWEx9CGfPjaarX67Ung+ML2IUdcKqEfOP1awXhQ4pYvOK0SeFUXWlMu5VfCBs
         9J6I7aKkPRXIxzRdeqy+uSQ/Jv6kkwyR9wxtORWm/JuQE1/y/tmw2l8N0YH3kwEARQ63
         yWA+Fa6PQZeU/hFJYDP/5arnRFSIGX5nG+QYc=
Received: by 10.236.80.10 with SMTP id j10mr8768857yhe.262.1308051951424; Tue,
 14 Jun 2011 04:45:51 -0700 (PDT)
Received: by 10.147.83.2 with HTTP; Tue, 14 Jun 2011 04:45:51 -0700 (PDT)
In-Reply-To: <BANLkTikDq8DJeUde-jSPL2bKw1jk3GoYVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175762>

Hi,

On Tue, Jun 14, 2011 at 8:00 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Hi,
>
> Jonathan Nieder writes:
>> I would love to use a working "cherry-pick --continue". :) =A0I woul=
d
>> use it like this:
>
> Great. =A0I hope to have a mockup of this ready in a couple of days o=
r so.

Yeah, you can work on "cherry-pick --skip" too.
If you have --continue and --skip working, maybe it will be worth mergi=
ng as is.

Thanks,
Christian.
