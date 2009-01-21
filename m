From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: feature request mergetool, skip, abort
Date: Wed, 21 Jan 2009 09:26:18 -0500
Message-ID: <81bfc67a0901210626i7cd75d1dh77c9cfae8b23b5c5@mail.gmail.com>
References: <81bfc67a0901200839q361923f1xb25ddadfdac37981@mail.gmail.com>
	 <20090121112236.GC18488@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 15:28:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPe3k-0000x7-3D
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 15:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743AbZAUO0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 09:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754367AbZAUO0W
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 09:26:22 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:53956 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145AbZAUO0V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 09:26:21 -0500
Received: by bwz14 with SMTP id 14so12849226bwz.13
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 06:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=N2r0GOMl8pZGl0YBo2/oLH9OAyYTTp7ejX+7xdIlcX4=;
        b=UtNRw40sy/oxIZvVLjizeXTBFnh89PEnHhsRsgbGlPAUDVt+E4/UnSatU5nOcC1hE7
         HGx/Nt5xvEpuqtnkwlr3azd6aZFm/XnWaVevi09lWwiISBiHKskqGaWpogY9w+o4FuT5
         4GD+kdeCrL9dtATeysQvZ0sTYIrNLuMNNzZJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PJC7w4Bdud/j03ow00pGmMNhpz1R+SiLf843scIhloGw4WnjZL7g+PgIy63e7m6CvL
         8+cL0XvSr2GpvAwstrGCpJC91FOq3LTjwsWY42mXv1YtmSLn58wZbUyOLC0A1I3bedXH
         iroPF+jt39g3r/t7A03F5dJSZebtczwvLF1LM=
Received: by 10.223.104.140 with SMTP id p12mr1472758fao.7.1232547978879; Wed, 
	21 Jan 2009 06:26:18 -0800 (PST)
In-Reply-To: <20090121112236.GC18488@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106605>

patch was an attachement.

after looking through the list and seeing the conventions I've a fully
working one now, so I'm going to start a new thread with it.
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
