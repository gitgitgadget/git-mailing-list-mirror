From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Tue, 17 Apr 2007 22:37:11 +1200
Message-ID: <46a038f90704170337k41ea4af0uc80dd2863ed477c3@mail.gmail.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	 <vpqejmjjrdp.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 12:37:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdl3r-0001pH-Rf
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 12:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbXDQKhN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 06:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbXDQKhN
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 06:37:13 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:48021 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514AbXDQKhM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 06:37:12 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1978353wxd
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 03:37:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YaVfKhpvqg+UTeVKLEFa9n5mmglJwX/svl68FEvooLXLP6Q/PTGo+kqdXSYRqXQsuO72D7RQ9vOKmjclPFctcbXFDYf092ut9goYyHIcdvlo9vzxPi8LVGrR1XXPRj4sZDwWMe2wxKeI3AlzBSVlWamjlijaXgdkM6pwVOfybj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RBYngOXjc25ZzQZOxZBuqQHHHQJ6SNZloZ3hC3jNftDkQyWLIrBp8c0/SUmWbapYahqQUZQ6f6kxjBJMj8Cn9PdHk7KMnVoOahsVvuk2B9iK1V75HihbABiFGtza8L1BWI/JMqwwY5qNVgAe0Wm7pmBflFK9dV8WmBhNeLxOH+w=
Received: by 10.90.92.7 with SMTP id p7mr5917603agb.1176806231537;
        Tue, 17 Apr 2007 03:37:11 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Tue, 17 Apr 2007 03:37:11 -0700 (PDT)
In-Reply-To: <vpqejmjjrdp.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44759>

On 4/17/07, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> If you have to argue against SVN, you'll need more than 15
> seconds ;-).

 - Same branch/merge limitations as CVS: knows how to branch, not how
to merge :-/

 - Repository corruption / Berkeley DB

cheers,


martin
