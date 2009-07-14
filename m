From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Truly decentralised use of git?
Date: Tue, 14 Jul 2009 20:09:32 +0200
Message-ID: <81b0412b0907141109j697f4705s4cebd27b9694dac7@mail.gmail.com>
References: <200907140811.24174.Karlis.Repsons@gmail.com>
	 <200907141323.02151.Karlis.Repsons@gmail.com>
	 <81b0412b0907140634g6aeec60fib23d56d83ba09fb9@mail.gmail.com>
	 <200907141558.54044.Karlis.Repsons@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?K=C4=81rlis_Repsons?= <karlis.repsons@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 20:09:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQmRh-0002um-Vn
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 20:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752AbZGNSJe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 14:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754401AbZGNSJe
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 14:09:34 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:47256 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbZGNSJe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 14:09:34 -0400
Received: by bwz28 with SMTP id 28so944325bwz.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l3Km52htC9VUKz9wW0NFO0V4QlAiC8UYqae8AcuC+A4=;
        b=FhCJTXKLn7nI2SMtJjTuToyPlgiWvq9VBuxArV5PVAHf2FzW6PvwtBJC8xnq1l24Sm
         4vTDjbe8IUCHa7P1Rd28pvpeTjJ0ovRbJ86d58h2Ktuz+Q23TkgB+t//ZTpXD6uUVWgD
         zJeoRiMLNyB7NCUWREo71wlDJHNBzMGs4K+iM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UaA5iiUPxHKQglVpG/eBfjjkvBcZYPUj7u9Cyil/Fyr8+M4ztPC3iBAYkTBJEhBx9z
         KM6yBFA0+UJhx9bZxXbFkq/CeW8gV7mFDb8fLDqxe5hMnnyBm704SmfihmXfN9yrOhRu
         SHBEpQ7rkIdf5QJIPGp0VFaky91ob6P+AGJDA=
Received: by 10.204.62.135 with SMTP id x7mr6613369bkh.95.1247594972108; Tue, 
	14 Jul 2009 11:09:32 -0700 (PDT)
In-Reply-To: <200907141558.54044.Karlis.Repsons@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123264>

On Tue, Jul 14, 2009 at 17:58, K=C4=81rlis Repsons<karlis.repsons@gmail=
=2Ecom> wrote:
> But can IPv6 usage provide a way for git users to pull from one anoth=
er
> directly?

Yes. Wanna use that argument for IPv6 promotion?
