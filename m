From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Suggested Workflow Question
Date: Wed, 18 Mar 2009 17:41:50 +1300
Message-ID: <46a038f90903172141o7b272c17v2c485bb66b529fe8@mail.gmail.com>
References: <loom.20090317T175010-470@post.gmane.org>
	 <49C04DFC.10201@earth.care2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Roger Garvin <yoyodyn@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Marcel M. Cary" <marcel@earth.care2.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 05:49:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljnii-0000ql-UR
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 05:49:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbZCREsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 00:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752676AbZCREsE
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 00:48:04 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:43362 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbZCREsD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 00:48:03 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2009 00:48:03 EDT
Received: by gxk4 with SMTP id 4so616076gxk.13
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 21:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NHrHjNNzkqD3u8Ma+KnXqwbMkv7kUTY/Z4ZK9hmnUPg=;
        b=kdiGT11XXHLayRP76o5XXYaJuT9R4cyWKm0UL1bf1rodyr6ljchjDII/EuaTPPJ8+C
         URQg51jN2/tNEIKf6czRD8ZUw1Che6WZoWeG/nHBxosFmlKsGSJRnpFOYMKHs0D6CS0D
         fvCadkA1DKINawtbc50Wtz+Y8GByrZ56jh8wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hg3vQYCCtYj/UgSH2FG2iYHOzfE4i3vpAaOaJugje6cQnWU/fjfYwuDykQn4K0lgAC
         YCBqOoL55T1FCazG1wHhlNZFob5F3r+En9nu9Vi9xzntPZRCb98WwjdoF29HX4qwXAXA
         lgRbLmcJZCKAL8wVzmXFWXDytVuEa3cxcLKOQ=
Received: by 10.142.103.11 with SMTP id a11mr320136wfc.208.1237351310733; Tue, 
	17 Mar 2009 21:41:50 -0700 (PDT)
In-Reply-To: <49C04DFC.10201@earth.care2.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113574>

On Wed, Mar 18, 2009 at 2:27 PM, Marcel M. Cary <marcel@earth.care2.com> wrote:
> * emailing patches when direct connections are not possible
> * test and dev branches for each customer

We've done a ton of that. Even better than emailing is that you can
have a repo on a usb stick/disk.

 - At the office, update it from the 'office' repository.
 - At the client site, pull updates from the usb stick, and push any
code developed at teh client side to the stick
 - Back at the office, push to the office repo

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
