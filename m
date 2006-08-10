From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit feature idea: multiple Patch tabs
Date: Thu, 10 Aug 2006 09:57:08 +0200
Message-ID: <e5bfff550608100057g7debc992pdc392dd9dca337f9@mail.gmail.com>
References: <eb9ub9$u5m$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 09:57:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB5Pn-00075c-Q0
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 09:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbWHJH5L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 03:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWHJH5L
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 03:57:11 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:16613 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161107AbWHJH5J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 03:57:09 -0400
Received: by py-out-1112.google.com with SMTP id z74so724034pyg
        for <git@vger.kernel.org>; Thu, 10 Aug 2006 00:57:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=meRQAz9dlIu4a19uyWCjESj29Q/1ePlfE//6c48d42ONu5jgOM1zN/dmSKnZUhLDcSBZbyx+6cWZI/RKuraG8d56c+GQuazU6vk6y9NSOFhEJjNOeJm/Kq1hzVQUpU/BG4HV5K6oqqtoKGLtzAeB/a39dl55EwhX8wsZDEodM5k=
Received: by 10.35.100.6 with SMTP id c6mr3359242pym;
        Thu, 10 Aug 2006 00:57:08 -0700 (PDT)
Received: by 10.35.52.17 with HTTP; Thu, 10 Aug 2006 00:57:08 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <eb9ub9$u5m$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25163>

On 8/8/06, Jakub Narebski <jnareb@gmail.com> wrote:
> It would be nice to be able to have multiple "Patch" tabs,
> e.g. by using "Open in new tab"/Ctrl-Click, instead of default
> being only one Patch tab, and new patch replacing the old.
>

I'm coming back after my holidays, and I'm trying to catch up with the
list....it will take some time. It seems I'm the only one to go for
holiday in this period ;-)

A couple of weeks ago I pushed a patch to support multiple "File" tabs.
Could your suggestion of  multi "patch" tabs follow the same
implementation line?
Or do you think we could do soemthing better with multi "Patch" tabs
(and back port to
multi "File" tabs patch)?

Thanks
Marco
