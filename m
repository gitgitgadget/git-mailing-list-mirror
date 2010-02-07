From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Gmail and unwanted line-wrapping
Date: Sat, 6 Feb 2010 19:51:43 -0500
Message-ID: <76718491002061651t2c10b9fcge3f139164dabe471@mail.gmail.com>
References: <bc341e101002061229t7a1525c2w2d5a8e221124b3c2@mail.gmail.com>
	 <fabb9a1e1002061247k7a8fba5at4c687faac0dcabb8@mail.gmail.com>
	 <20100207002413.GA14744@gmail.com>
	 <76718491002061650ge299426s22de5e00b26af108@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 01:51:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdvNV-00060j-60
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 01:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756623Ab0BGAvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 19:51:52 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:46312 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181Ab0BGAvv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 19:51:51 -0500
Received: by iwn27 with SMTP id 27so851676iwn.5
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 16:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=RH8loXz0NDn4kvoFf3GRttShjpobW8J26HWAOG8ZG0E=;
        b=B/zUGwswWWwg0O9EgklF3rKYLBbEOCS26iP2uyOqpHviSrY1ZWPowocK0ET7ChqF1q
         UvMeSIA8W/SXrGNN0U4gDbFw3biGFnUd2S3OgS48m92N8dVl7VpPxhG7ipXJzWzTPKck
         1HMxLC9Kq74GH0rMm3RnWQJ89V/N7qaei1HFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Bh0mZM9XcnZIJNz5b1NFIn8vVdNVhbkiSDZlA0V2NG18t02/LzD5iKvHPQz7oWT+iy
         PCsUx6pBAFJRV9iRxicdMlSf9bE6iDNIkSjhPqDvApJtL9EfedbxYTPfnq4v5oBz+cya
         HkqsmNWoY1UKNyzFNAFSSZa5cNuhN9LtdJ9Qc=
Received: by 10.231.149.201 with SMTP id u9mr3134186ibv.1.1265503903771; Sat, 
	06 Feb 2010 16:51:43 -0800 (PST)
In-Reply-To: <76718491002061650ge299426s22de5e00b26af108@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139203>

On Sat, Feb 6, 2010 at 7:50 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> tls_trust_file /opt/local/share/curl/curl-ca-bundle.crt

Actually you need the curl-ca-bundle port.

j.
