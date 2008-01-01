From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: qgit 2.1 questions about range selection
Date: Tue, 1 Jan 2008 21:03:18 +0100
Message-ID: <87845E66-B8BD-4CE4-BBA8-91A90524B62D@zib.de>
References: <771EDDAF-F479-45F7-AB85-F7B6603FB061@zib.de> <e5bfff550801010733k63ed0c3du273f28b684efe904@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 21:02:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9nJy-0004YD-2L
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 21:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883AbYAAUCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 15:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbYAAUCP
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 15:02:15 -0500
Received: from mailer.zib.de ([130.73.108.11]:35174 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754574AbYAAUCO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 15:02:14 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m01K2CJL023257;
	Tue, 1 Jan 2008 21:02:12 +0100 (CET)
Received: from [192.168.178.21] (brln-4db823e6.pool.einsundeins.de [77.184.35.230])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m01K2Bhr019414
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 1 Jan 2008 21:02:11 +0100 (MET)
In-Reply-To: <e5bfff550801010733k63ed0c3du273f28b684efe904@mail.gmail.com>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69444>

Hello Marco,

On Jan 1, 2008, at 4:33 PM, Marco Costalba wrote:

> On Dec 31, 2007 11:42 AM, Steffen Prohaska <prohaska@zib.de> wrote:
>>
>> Here is a first impressions and some questions about the range
>> selection, which I find pretty hard to understand.
>>
>
>   I have just pushed to
>
> git://git.kernel.org/pub/scm/qgit/qgit4.git
>
> a patch series that should address some of your concerns.

Thanks.  The changes work for me.

Two minor remarks:

  - I'd call the menu entry "View > Select range..." instead of
    "View > Open range dialog...".  This is shorter and the
    dots already indicate that a dialog will open.

  - I find the wizard icon in the menu entry confusing.  The
    wizard icon is already associated with "Toggle filter by
    tree".  It should be reserved for this.

	Steffen
