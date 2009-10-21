From: Thomas Adam <thomas.adam22@gmail.com>
Subject: Re: Feature request: Store comments on branches
Date: Wed, 21 Oct 2009 14:46:19 +0100
Message-ID: <18071eea0910210646l41f18deam8c75f1218df7e25a@mail.gmail.com>
References: <20091021133702.GA470@lisa>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Patrick Schoenfeld <schoenfeld@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 15:52:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0bWk-0004S9-Gl
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 15:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbZJUNqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 09:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbZJUNqt
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 09:46:49 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:46492 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbZJUNqs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 09:46:48 -0400
Received: by ewy3 with SMTP id 3so6057011ewy.17
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=BLvts2Xb6o8Y2ORW2yVZNBOlFnu2qwZ8ZQ5zy9jblok=;
        b=PYjDedrcVRGBlqzt4L5PA2eo92dMdjEImyzW1Ax+lesFPWVDO/Hf9a7JLkGYBr6JUn
         JZ6HbPiA9AGR69rUDx2sP/1UDGkjHxDGaoaMhi7uNJBfd1XnM9NF61DARp1Zj1yCBsED
         UAXtHIMvY9i/mY7takI/ayUmgCN2iE9yTMC5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=MfcjqfhKiIOz3lywj9IGU1kvv+GvenPz7djUL7QhxU6rrt8UBLhqvF9c6eGyIKK0cI
         TkJsUPsC5XPg5b66v7OUm94CnQYlTy/kyYY5XM5GC3vtOcYZWkNnH6U9rue1VLLlvY/6
         XHrfqIjZ8ByH6gQzd6v9pGTgtGTEH8Jm/vkKE=
Received: by 10.216.87.144 with SMTP id y16mr311247wee.95.1256132812113; Wed, 
	21 Oct 2009 06:46:52 -0700 (PDT)
In-Reply-To: <20091021133702.GA470@lisa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130915>

2009/10/21 Patrick Schoenfeld <schoenfeld@debian.org>:
> What do others think about this? Would this be useful
> for others, too?

This feature is already being worked on as "git notes" -- see the "pu"
branch, I think it's still in there, unless it has graduated to next;
I forget now.

-- Thomas Adam
