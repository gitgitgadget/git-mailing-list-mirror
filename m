From: Greg Price <price@ksplice.com>
Subject: Re: [PATCH] rebase -i -p: document shortcomings
Date: Tue, 1 Jun 2010 13:24:03 -0400
Message-ID: <AANLkTik-piGwunSM4zsSBR5U8uzuN58IgtFRFV54XzkJ@mail.gmail.com>
References: <20100601014335.GA21970@progeny.tock>
	<AANLkTimjcHpbbpfwNoZGq3_1TjfLAzJL3C8Jcp6LeyW0@mail.gmail.com>
	<AANLkTimy22yhbxDEfcIg5nPxguWslCIrIEk6wH9kzZqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Florian Weimer <fw@deneb.enyo.de>,
	=?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg@alea.gnuu.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 19:29:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJVHB-00005T-So
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 19:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678Ab0FAR3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 13:29:12 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:45473 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab0FAR3L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 13:29:11 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jun 2010 13:29:11 EDT
Received: by ewy23 with SMTP id 23so388833ewy.1
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 10:29:07 -0700 (PDT)
Received: by 10.213.7.135 with SMTP id d7mr3801258ebd.52.1275413044034; Tue, 
	01 Jun 2010 10:24:04 -0700 (PDT)
Received: by 10.213.35.142 with HTTP; Tue, 1 Jun 2010 10:24:03 -0700 (PDT)
In-Reply-To: <AANLkTimy22yhbxDEfcIg5nPxguWslCIrIEk6wH9kzZqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148144>

On Tue, Jun 1, 2010 at 7:40 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Tue, Jun 1, 2010 at 04:22, Greg Price <price@ksplice.com> wrote:
>> Thanks, this is long needed.  I regret that I haven't had time in
>> several months to continue work on the real fix.
>
> Is it your or Jonathan's intent on finishing Dscho's work on rebase -i -p?

That was my plan.  I did some work in that direction, which is at
http://repo.or.cz/w/git/price.git/shortlog/refs/heads/rebase-i-p
and which I discussed with Dscho last November:
http://thread.gmane.org/gmane.comp.version-control.git/131921/focus=132156

Unfortunately work has made me busy with non-Git subjects since
December.  I would like to finish the work, but I cannot make
promises.

Greg
