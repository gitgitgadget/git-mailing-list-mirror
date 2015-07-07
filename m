From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/12] Improve git-am test coverage
Date: Tue, 07 Jul 2015 20:34:25 +0200
Organization: gmx
Message-ID: <7003ba8bfb1847c7e4971fab2a2591ab@www.dscho.org>
References: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 20:35:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCXhs-0002es-F4
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 20:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933218AbbGGSez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 14:34:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:49198 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933580AbbGGSea (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 14:34:30 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MNqfr-1Z6js13VqV-007VjV; Tue, 07 Jul 2015 20:34:26
 +0200
In-Reply-To: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:u9hg6oLMuWEIxHZVnJ7gURERI76w0Gw7vkhWG7VK0b6GCU768K/
 FeP+yCFzRStvjp/YDkkVXEx3iKueuLuAf4wtgkt6JA4B2Ky98R7fRoUE8FJvW1DUEzK7zMf
 sWpqjqS9uvvDEVVR/tOk6jXiQ/Dgbgg61GwMjM0+XgN1pZowU8VWcdO6+8aDkfKYizLHrqi
 kQ6YEs6kopmB950uJl2+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Eom8APxEPIg=:nV8tq3wqvppuxKSJ0u+nCh
 u5cO5eV7jb9habke+tvsroeOOeEtqCYtDjP+Fc9Qu4GST5eUhEoKOvj4KFh+MmlOtnqFD52Dj
 McMHAh6SAY5wV4ln3YMvEUY3H3ixhigg/ysqHIw7JrLR42hzU3J4IMCarevOvbT5+sy5galjz
 bWXU9MJEnTqRW+0ik2KtUivAMwVbW6HOdKMLtDhV8slE8XlnIh9E9C8pMYkCyQKdESDF6klHv
 pLBPElBO+k509XI9QyHRWIgNUIUVmDSrxShQ7hBN302mu87QWbJBwOm8TC5EEyC/xnEFRyjS9
 l3SMBK2DKS0q2o2EmV3NvPbZxRckYwnU6XOqYTbV6aSwTtHu3oDFiYAsqe3P5tVCVPwwFial1
 BAef2LtGjeAMFcVYZUfMvQ0+9x2Ijeg+f/qk9PPOPQy6AnNeaXd/88KHnu9UIcIN4rEom6kpN
 sH6lfJttYN90fDwf2/hCjbafeEcydN3DnVF4srMVOoMbXD8N5XTO1fgMwYHtSRevsZvAc9MB5
 I7V2jKrYizyVXPs4bcnJHx//BdCej2aGf9OefUQVVojWn+FITb0eN7P4WCYJ0jhsxpQ7lSn4H
 0IEdHxzkqNTy8TAtDDbXdH0jK5n1fxABXmFltFnBBY2Um9s0rFUItEHJeaWZPHKU/saPoVKrk
 EffkaN/B6WSnXaSyrFP8oM11NwS70x3ufO32EKe9EPWluu6RBDOFIln0e213rW5L+R9E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273591>

Hi Paul

On 2015-07-07 16:08, Paul Tan wrote:
> This is a re-roll of [v1]. Thanks Junio, Johannes, Paolo, Stefan for the
> reviews last round. Interdiff below.

Interdiff looks good to me!

Thanks,
Dscho
