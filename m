From: Matthias Kestenholz <mk@feinheit.ch>
Subject: Re: encrypted repositories?
Date: Fri, 17 Jul 2009 16:30:39 +0000
Message-ID: <1f6632e50907170930w4860b841i3a6028ea47c4d522@mail.gmail.com>
References: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 17 18:30:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRqKe-0001Iv-DO
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 18:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbZGQQan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 12:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbZGQQal
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 12:30:41 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:37509 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964899AbZGQQak (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 12:30:40 -0400
Received: by ewy26 with SMTP id 26so990532ewy.37
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 09:30:39 -0700 (PDT)
Received: by 10.210.119.5 with SMTP id r5mr826417ebc.81.1247848239217; Fri, 17 
	Jul 2009 09:30:39 -0700 (PDT)
In-Reply-To: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123473>

On Fri, Jul 17, 2009 at 3:14 PM, Matthias Andree<matthias.andree@gmx.de> wrote:
>
> How would one go about this from the user side? I sincerely doubt I have the
> resources (time!) to actually implement this in Git.
>

Maybe you could send around packages created by git-bundle as
pgp-encrypted emails, and keep the original on your computer on an
encrypted filesystem? You could also encrypt the bundles and put them
onto a public server if that suits you better than email.

The biggest advantage of this approach would be that it can be done
now, and no changes to git itself are required.


Matthias
