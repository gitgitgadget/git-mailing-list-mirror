From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Wed, 18 Jan 2012 07:18:51 +0530
Message-ID: <CAMK1S_j8zJ3Lrz7R2gNV500Ata2rG6R=E0p8ptaB675XqGDi0g@mail.gmail.com>
References: <jbvj5o$skt$1@dough.gmane.org>
	<20111217101009.GA19248@sita-lt.atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Gelonida N <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 02:49:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnKeI-0002oC-1p
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 02:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133Ab2ARBsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 20:48:54 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:49677 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754351Ab2ARBsw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2012 20:48:52 -0500
Received: by obcva7 with SMTP id va7so6582534obc.19
        for <git@vger.kernel.org>; Tue, 17 Jan 2012 17:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9LUuK39YpgrIba5+Jg316Lng9fPQlo9/qVEo720AB7Q=;
        b=G+vzbX//PcdmyhTQ8JXFQqes4BMvGPUodNaJWSjgIxQsmCJoKd5GdQWXr7GA3J8BT7
         rdCIKZ7/Z2zMso175t11q37+4HqDBp4Moi5E90fml+Ov0IXY1eZ202cvAYbW5uTSf8pD
         mPyVhMFL2Rw1W0/KeYjpoB0Gur9Ow9mN+t6x0=
Received: by 10.182.117.8 with SMTP id ka8mr17143975obb.73.1326851331881; Tue,
 17 Jan 2012 17:48:51 -0800 (PST)
Received: by 10.182.51.170 with HTTP; Tue, 17 Jan 2012 17:48:51 -0800 (PST)
In-Reply-To: <20111217101009.GA19248@sita-lt.atc.tcs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188736>

On Sat, Dec 17, 2011 at 3:40 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> On Sat, Dec 10, 2011 at 01:26:32PM +0100, Gelonida N wrote:
>> Hi,
>>
>> What is the best way to fastforward all fastforwardable tracking
>> branches after a git fetch?
>
> I know this is a somewhat closed topic, but I took some time to
> clean up a program I have been using for a while, including some

A month later and I find I have modified this program
