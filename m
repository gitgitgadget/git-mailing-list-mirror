From: Suraj Kurapati <sunaku@gmail.com>
Subject: Re: [RFC PATCH] add -p: prompt for single characters
Date: Sun, 1 Feb 2009 19:31:53 -0800
Message-ID: <cfbcd2f00902011931h48ef51a4n9badbed9051879ca@mail.gmail.com>
References: <1233520511-13061-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 02 04:33:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTpYn-00049Z-Fd
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 04:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103AbZBBDbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 22:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753655AbZBBDbz
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 22:31:55 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:62123 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbZBBDby (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 22:31:54 -0500
Received: by qyk4 with SMTP id 4so1708021qyk.13
        for <git@vger.kernel.org>; Sun, 01 Feb 2009 19:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PvWCvmyOqwK9ucUeJ3xpiePe1qfJo7SrvezWHA+qRFk=;
        b=n8xsZmlP4H85wOzS1uT8Dokz0yMyZJFu6qgyAkvDkm3Eskl+8C0/Jlie9NIgtPP6pc
         P4mKRuoo+RwaCgj9ozZFi2NVjhU+SvXa8nLfvesN4R0nNd3kIo5XH8SbbPWp8u81BLk1
         Sas99IgYNAdT7Ox/SmVrzsm6Fr2R2MFta+kHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oOeOrE4NGzVzJZ1/AUqttgV4ga+03rhPYtnnBCTS8WVZySg4RhPd17xI1MpG5E4HU/
         WgOMHJMCsLzkZZMhxobvcME44wckBXCcxveR93i95y9zD8yT3BzerKoE0G47IVwC3jmm
         NELVH1+LKq/MHvIE1OBXs8t0RNC0osboCNCY0=
Received: by 10.214.218.16 with SMTP id q16mr1664389qag.353.1233545513237; 
	Sun, 01 Feb 2009 19:31:53 -0800 (PST)
In-Reply-To: <1233520511-13061-1-git-send-email-trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108040>

On Sun, Feb 1, 2009 at 12:35 PM, Thomas Rast <trast@student.ethz.ch> wrote:
>  http://thread.gmane.org/gmane.comp.version-control.git/100146
>
> I can't find the v4 promised there, so I assume Suraj dropped it.

Yes, I lost the motivation to develop the patch any further.  Sorry.

But I am glad to see you carrying the torch forward.  Good luck! :)
