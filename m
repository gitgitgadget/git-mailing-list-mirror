From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Feature Request: Capability to save and load the workspace
Date: Fri, 31 Jul 2009 11:09:58 +0200
Message-ID: <40aa078e0907310209p458cf912r1eb4329a409cefa7@mail.gmail.com>
References: <4A72AF1C.1020500@ubicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yakup Akbay <yakbay@ubicom.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 11:10:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWo89-00039y-Vc
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 11:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbZGaJKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 05:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbZGaJKK
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 05:10:10 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:37252 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbZGaJKA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 05:10:00 -0400
Received: by fxm17 with SMTP id 17so1249165fxm.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=J3BA5jCcLbbGuf7EZd4/2LrxkrenG/Jt82ojNVm0gV8=;
        b=A1QPprn09mZv9WiWccqYVdyN/K2E5wpSG5g6hd5av6c7Y/pSf+580jariW4msBi+Xl
         MWHG3vK/dqL2F/3Ib2HfrhHwIJxjaD6uh4kPDgVujTCE/zDT8Q9lhUC24k4d29lnlIm6
         lAVR2OjI/jQgY2WoRXQD3gooV+sJHZ3nU/17w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Td9bF1JLHvFTIwkEiOjUcjXw2683gqptq30AsvjxrDJP+U+gm+7n0N8JptD6sDd2QR
         Ku0NE80cf6g42HADCfWT4MvdFqgi4tvKGc3j5msg0DQp5geJl0TW3UCPS8A64bM6l8J6
         Ad12GyodQ1o+jmbB0L9G+ssCZ01um/bQbuKf8=
Received: by 10.204.102.14 with SMTP id e14mr2478526bko.183.1249031398979; 
	Fri, 31 Jul 2009 02:09:58 -0700 (PDT)
In-Reply-To: <4A72AF1C.1020500@ubicom.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124514>

On Fri, Jul 31, 2009 at 10:45 AM, Yakup Akbay<yakbay@ubicom.com> wrote:
> IT WOULD BE NICE to have a feature in git that allows us to save the
> current workspace then work on a different profile on a clean
> environment. Then save that profile and switch back to the previous
> profile at any time without losing the environment.

Did you have a look at the stash command yet? I might be missing
something, but it looks to me like it's exactly what you're looking
for...

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
