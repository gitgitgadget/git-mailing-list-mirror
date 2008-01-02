From: Gregory Jefferis <jefferis@gmail.com>
Subject: Re: Git and securing a repository
Date: Wed, 02 Jan 2008 19:41:29 +0000
Message-ID: <C3A19969.1083F%jefferis@gmail.com>
References: <20080102193114.GA4608@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Jan 02 20:42:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA9Tc-0004o6-HG
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 20:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbYABTlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 14:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753621AbYABTlh
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 14:41:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:39964 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548AbYABTlg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 14:41:36 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2559631ugc.16
        for <git@vger.kernel.org>; Wed, 02 Jan 2008 11:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        bh=jHkgF9M9uWdLzNCd0hEUvCHUYoTe51P2nc1tbZzdMjQ=;
        b=knyy23pZrVDTMKyWZNTtrvp9mra9AcRKoR8sSaWssspez2L8MLbXNKhUsp6BSw6FdIknoqucR3vG1QkTT3Gw5u3Vs1GwCEL/O37dIfc0vL949PqSKQWKE65ZxXDP2p31luhaFvpzhmo3xpBF5fDzv8KVARlmXRdqiDXNJYi5uJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        b=lv43mlj2SbsMRjDaDEkSVOzI7bywK4VY6rnRI+4hLAiqcISaR2ZqVTeGZqOjWeZ88o+Chh1jUeS93NjmgwRNqyTl4BHA+GbxDsyG11s5SoSiwqJZ/ExOmUfuXIh07K0ufqxZFR2EcCsI7+y+t6//J/LzLw9/G+cyguSJGV8GGIU=
Received: by 10.66.219.11 with SMTP id r11mr14685824ugg.31.1199302893823;
        Wed, 02 Jan 2008 11:41:33 -0800 (PST)
Received: from ?81.98.250.69? ( [81.98.250.69])
        by mx.google.com with ESMTPS id t35sm15782175uge.81.2008.01.02.11.41.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Jan 2008 11:41:32 -0800 (PST)
User-Agent: Microsoft-Entourage/11.2.3.060209
Thread-Topic: Git and securing a repository
Thread-Index: AchNd3gDtq2on7lqEdyDSgAUURoPUg==
In-Reply-To: <20080102193114.GA4608@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69489>

On 2/1/08 19:31, "Jan Hudec" <bulb@ucw.cz> wrote:

> 
> You don't need to manage user accounts -- managing ssh public keys will do!

Has anyone used gitosis?

http://eagain.net/gitweb/?p=gitosis.git

http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-secure-w
ay

It seems to make setting up this kind of approach easier.

Best,

Greg.

-- 
Gregory Jefferis, PhD                               and:
Research Fellow
Department of Zoology                               St John's College
Downing Street                                      Cambridge
Cambridge, CB2 3EJ                                  CB2 1TP 
